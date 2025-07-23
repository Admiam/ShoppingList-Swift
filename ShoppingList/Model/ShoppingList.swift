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

}

