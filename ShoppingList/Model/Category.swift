//
//  Category.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import Foundation
import SwiftUI

struct Category: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var accent: Color {
        switch id {
        case "fish":             return .teal
        case "meat":             return .red
        case "vegetablesFruits": return .green
        case "dairy":            return .blue.opacity(0.7)
        case "sweets":           return .pink
        case "freeze":           return .cyan
        case "bakery":           return .orange
        case "drink":            return .yellow.opacity(0.8)
        case "drugs":            return .indigo
        case "cleaning":         return .mint
        case "cereals":          return .yellow
        case "canned":           return .gray
        case "pasta":            return Color("Pasta")      // asset
        case "baby":             return .purple.opacity(0.7)
        case "pet":              return .brown
        case "household":        return .gray.opacity(0.6)
        case "health":           return .green.opacity(0.7)
        default:                 return .secondary
        }
    }
}
