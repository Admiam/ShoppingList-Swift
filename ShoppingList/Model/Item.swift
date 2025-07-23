//
//  Item.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import Foundation
import SwiftUI
import CoreLocation

struct Item: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var isBought: Bool
    var category: String
}
