//
//  ContentView.swift
//  ShoppingList
//
//  Created by Adam Míka on 18.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    @State var isClicked: Bool = false
    @State private var newItemName: String = "Rohlik"

    enum Tab {
        case featured
        case list
    }
    
    enum Field { case item }
        @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
//                    UIApplication.shared.endEditing()
                }
            VStack(spacing: 20) {
                HStack(spacing: 12) {
                    Button {
                        isClicked.toggle()
                    } label: {
                        Image(systemName: isClicked ? "circle.fill" : "circle")
                            .foregroundStyle(.purple)
                            .font(.system(size: 22))
                    }
                    .buttonStyle(.plain)
                    VStack(spacing: 4){
                        TextField("Item", text: $newItemName)
                            .focused($focusedField, equals: .item)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.none)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.purple)
                        
                        Divider()
                            .background(.gray)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 36)
                .contentShape(Rectangle())
            }
        }
    }
}

#Preview {
    ContentView()
}
