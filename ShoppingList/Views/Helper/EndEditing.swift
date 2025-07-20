//
//  EndEditing.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//

import SwiftUI
#if canImport(UIKit)
extension UIApplication {
  func endEditing() {
    sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil, from: nil, for: nil
    )
  }
}
#endif
