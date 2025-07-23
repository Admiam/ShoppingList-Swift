//
//  AddItemView.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//
import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var store: StoreFile
    @Environment(\.dismiss) var dismiss
    var list: ShoppingList
    @State private var name = ""
    @State private var selectedCategory: Category?
    

    var body: some View {
        NavigationView {
            Form {
                TextField("New item name", text: $name)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.none)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(store.categories) { cat in
                        Text(cat.title).tag(Optional(cat))
                    }
                }
            }
            #if !os(watchOS)
                .navigationTitle("Add Item")
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        print(store.categories)
                        guard
                            let cat = selectedCategory,
                            !name.trimmingCharacters(in: .whitespaces).isEmpty
                        else { return }
                        
                        store.addItem(name, to: list, in: cat.id)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                // choose first category by default if none yet selected
                if selectedCategory == nil { selectedCategory = store.categories.first }
            }
        }
    }
    
}

