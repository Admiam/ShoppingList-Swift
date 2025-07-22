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
    
    //    enum Field { case item }
    //    @FocusState private var focusedField: Field?
    
    //    @State var isClicked: Bool = false
    //    @State private var newItemName: String = "Rohlik"
    //
    //
    //    enum Field { case item }
    //        @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                //                Color.clear
                //                    .contentShape(Rectangle())
                //                    .ignoresSafeArea()
                //                    .onTapGesture {
                //                        focusedField = nil
                //                        //                    UIApplication.shared.endEditing()
                //                    }
                
                
                List {
                    ForEach(store.categories) { category in
                        categorySection(for: category, in: list)
//                        let itemsInCat = store.lists[list.id].items.filter { $0.category == category.id }
//                        if !itemsInCat.isEmpty {
//                            Section {
////                            (header: Text(category.title))
//                                ForEach(itemsInCat) { item in
//                                    ItemRow(item: item)
//                                        .environmentObject(store)
//                                }
//                                .onDelete { offsets in
//                                    offsets.map { itemsInCat[$0] }
//                                        .forEach(store.deleteItem)
//                                }
//                            } header: {
//                                Text(category.title)
//                                    .font(.headline)
//                                    .foregroundStyle(category.accent)
//                            }
//                            .listRowBackground(category.accent.opacity(0.1))
//                        }
                    }
                }
                
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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


