//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Adam Míka on 22.07.2025.
//

import Foundation

struct ShoppingList: Codable, Identifiable, Hashable {
    var id: UUID
    var title: String
    var items: [Item]
//    var categories: [Category]
    
//    func loadCategories(_ filename: String) {
//        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            self.categories = try JSONDecoder().decode([Category].self, from: data)
//        } catch {
//            fatalError("Couldn't load or parse \(filename): \(error)")
//        }
//    }
}

