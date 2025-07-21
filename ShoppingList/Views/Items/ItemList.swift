//
//  ItemList.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI

struct ItemList: View {
    @EnvironmentObject var store: StoreFile
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
                        let itemsInCat = store.items.filter { $0.category == category.id }
                        if !itemsInCat.isEmpty {
                            Section {
//                            (header: Text(category.title))
                                ForEach(itemsInCat) { item in
                                    ItemRow(item: item)
                                        .environmentObject(store)
                                }
                                .onDelete { offsets in
                                    offsets.map { itemsInCat[$0] }
                                        .forEach(store.deleteItem)
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
                AddItemView()
                    .environmentObject(store)
            }
        }
    }
}

#Preview {
    let store = StoreFile()
    ItemList()
        .environmentObject(store)
}

