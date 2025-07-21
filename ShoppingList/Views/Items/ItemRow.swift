//
//  ItemRow.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var store: StoreFile
//    @Binding var item: Item
    let item: Item
    
    @State private var draftName: String

    init(item: Item) {
        self.item = item
        _draftName = State(initialValue: item.name)   // <-- seed the draft
    }

//    @State var isClicked: Bool = false
//    @Binding private var newItemName: String = item.name

    
//    enum Field { case item }
//        @FocusState private var focusedField: Field?
    
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                //                isClicked.toggle()
                store.toggleBought(item)
            } label: {
                Image(systemName: item.isBought ? "circle.fill" : "circle")
                    .foregroundStyle(.purple)
                    .font(.system(size: 16))
            }
            .buttonStyle(.plain)
            
            //            VStack(spacing: 4){
            //                TextField("Item",
            //                          text: $item.name,
            //                          onCommit: { store.saveToDisk() })
            ////                    .focused($focusedField, equals: .item)
            //                    .disableAutocorrection(true)
            //                    .textInputAutocapitalization(.none)
            //                    .font(.system(size: 24, weight: .bold))
            ////                    .foregroundStyle(.purple)
            //
            //                Divider()
            //                    .background(.gray)
            //            }
            //            Text(item.name)
            //                .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(item.isBought ? .gray : .primary)
            TextField("Item",
                      text: $draftName,
                      onCommit: commitRename)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(item.isBought ? .gray : .primary)

            Spacer()
            
            if item.isBought {
                Button {
                    store.deleteItem(item)
                } label: {
                    Image(systemName: "trash")
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.vertical, 12)
//        .padding(.horizontal, 36)
        .contentShape(Rectangle())
    }
    private func commitRename() {
        let trimmed = draftName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { draftName = item.name; return }
        store.rename(item, to: trimmed)
    }
}

#Preview {
    ItemList()
//        .environment(.colorScheme(.dark))
//        .environment(StoreFile())
}
