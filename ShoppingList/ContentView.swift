//
//  ContentView.swift
//  ShoppingList
//
//  Created by Adam Míka on 18.07.2025.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: StoreFile
    @State private var showingAdd = false
    @State private var newTitle = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(store.lists) { list in
                    NavigationLink(list.title) {
                        ItemList(list: list)
                    }
                }
                .onDelete { offsets in
                    offsets.map { store.lists[$0] }.forEach(store.deleteList)
                }
            }
            .navigationTitle("My Shopping Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showingAdd = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingAdd) {
                NavigationView {
                    Form {
                        TextField("List title", text: $newTitle)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.none)
                    }
                    .navigationTitle("New List")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Create") {
                                guard !newTitle.isEmpty else { return }
                                store.addList(title: newTitle)
                                newTitle = ""
                                showingAdd = false
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel", role: .cancel) { showingAdd = false }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let store = StoreFile()
    ContentView()
        .environmentObject(store)
}
