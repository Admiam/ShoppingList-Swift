//
//  ItemRow.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var store: StoreFile
    let item: Item

//    @State var isClicked: Bool = false
//    @State private var newItemName: String = "Rohlik"

    
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
                    .font(.system(size: 20))
            }
            .buttonStyle(.plain)
            
            //            VStack(spacing: 4){
            //                TextField("Item", text: item.name)
            ////                    .focused($focusedField, equals: .item)
            //                    .disableAutocorrection(true)
            //                    .textInputAutocapitalization(.none)
            //                    .font(.system(size: 24, weight: .bold))
            ////                    .foregroundStyle(.purple)
            //
            //                Divider()
            //                    .background(.gray)
            //            }
            Text(item.name)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(item.isBought ? .gray : .primary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.vertical, 12)
//        .padding(.horizontal, 36)
        .contentShape(Rectangle())
    }
}

#Preview {
    ItemList()
//        .environment(.colorScheme(.dark))
//        .environment(StoreFile())
}
