//
//  ItemRow.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var store: StoreFile
    
    var item: Item
    var list: ShoppingList

    @State private var draftName: String


    init(item: Item, in list: ShoppingList) {
        self.item   = item
        self.list   = list
        _draftName = State(initialValue: item.name)
    }
    
    enum Field { case item }
        @FocusState private var focusedField: Field?
    
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            HStack(spacing: 12) {
                let itemCategory = store.categories.first { $0.id == item.category }
                let tint = itemCategory?.accent ?? .secondary
                
                Button {
                    store.toggleBought(item, in: list)
                } label: {
                    Image(systemName: item.isBought ? "circle.fill" : "circle")
                        .foregroundStyle(tint)
                        .font(.system(size: 16))
                }
                .buttonStyle(.plain)
                .foregroundStyle(item.isBought ? .gray : .primary)
                
                Text(item.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(item.isBought ? .gray : .primary)
                    .textFieldStyle(.plain)
                Spacer()
                
                if item.isBought {
                    Button {
                        store.deleteItem(item, from: list)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(tint)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
    }
    private func commitRename() {
        let trimmed = draftName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { draftName = item.name; return }
        store.rename(item, in: list, newName: trimmed)
    }
}

#Preview {
    // sample data
    let fishCat = Category(id: "fish", title: "Fish")
    let item = Item(id: .init(), name: "Salmon", isBought: false, category: "fish")
    let list = ShoppingList(id: .init(), title: "Demo", items: [item])
    let store = StoreFile()

    ItemRow(item: item, in: list)
        .environmentObject(store)
    }
