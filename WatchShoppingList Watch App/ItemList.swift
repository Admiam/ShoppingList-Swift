//
//  ItemList.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI

struct ItemList: View {
    @EnvironmentObject var store: StoreFile
    let list: ShoppingList
    @State private var showingAddSheet = false
    @Environment(\.presentationMode) private var presentation

    var body: some View {
        NavigationStack {
                List {
                    ForEach(store.categories) { category in
                        categorySection(for: category, in: list)
                    }
                }
                .safeAreaPadding(.top)
                .padding(.top, 3)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddItemView(list: list)
                    .environmentObject(store)
            }
    }
    @ViewBuilder
       private func categorySection(for category: Category,
                                    in list: ShoppingList) -> some View {
           let items = list.items.filter { $0.category == category.id }

           if !items.isEmpty {
               Section {
                   ForEach(items) { item in
                       ItemRow(item: item, in: list)
                           .environmentObject(store)
                   }
                   .onDelete { offsets in
                       offsets
                           .map { items[$0] }
                           .forEach { store.deleteItem($0, from: list) }
                   }
               } header: {
                   Text(category.title)
                       .font(.headline)
                       .foregroundStyle(category.accent)
               }
               .listRowBackground(category.accent.opacity(0.1))
           }
       }
   }

#Preview {
    let store = StoreFile()
    let demoList = ShoppingList(
        id: .init(),
        title: "Saturday Costco",
        items: [
            Item(id: .init(), name: "Salmon Fillet", isBought: false, category: "fish")
        ]
    )
    store.lists = [demoList]
    return ItemList(list: demoList)
        .environmentObject(store)
}


