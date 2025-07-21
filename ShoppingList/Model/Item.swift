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
    
//    enum Category: String, CaseIterable, Codable {
//        case other = "Other"
//        case fish = "Fish"
//        case meat = "Meat"
//        case vegetablesFruits = "Vegetables & Fruits"
//        case dairy = "Dairy"
//        case sweets = "Sweets"
//        case freeze = "Frozen Foods"
//        case bakery = "Bakery"
//        case drink = "Beverages"
//        case drugs = "Personal Care"
//        case cleaning = "Cleaning Supplies"
//        case cereals = "Cereals & Breakfast"
//        case canned = "Canned & Jarred Goods"
//        case pasta = "Dry Goods & Pasta"
//        case baby = "Baby Products"
//        case pet = "Pet Supplies"
//        case household = "Household Items"
//        case health = "Health & Wellness"
//    }
}
