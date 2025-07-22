//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Adam Míka on 18.07.2025.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    @StateObject private var store = StoreFile()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentView()
                .environmentObject(store)
        }
    }
}
