//
//  StoreFile.swift
//  ShoppingList
//
//  Created by Adam Míka on 20.07.2025.
//
import Foundation

class StoreFile: ObservableObject {
    @Published var items: [Item] = []
    @Published var categories: [Category] = []
    
    private let fileURL: URL
    
    init(filename: String = "shopping.json") {
            let docs = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first!
            self.fileURL = docs.appendingPathComponent(filename)
            loadCategories("categories.json")
            loadFromDisk()
            saveToDisk()
           
        }
    
    func addItem(_ name: String, to category: String) {
        let newItem = Item(id: .init(), name: name, isBought: false, category: category)
        items.append(newItem)
        saveToDisk()
    }
    
    func toggleBought(_ item: Item){
        guard let inx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[inx].isBought.toggle()
        saveToDisk()
    }
    
    func deleteItem(_ item: Item){
        items.removeAll { $0.id == item.id}
        saveToDisk()
    }
    
    func loadFromDisk() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let loadedItems = try decoder.decode(ModelData.self, from: data)
            self.items = loadedItems.items
//            self.categories = loadedItems.categories
        } catch {
            print("Error loading data from disk. Starting with empty store.")
//            self.categories = []
            self.items = []
        }
    }
    
    func loadCategories(_ filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            let data = try Data(contentsOf: url)
            self.categories = try JSONDecoder().decode([Category].self, from: data)
        } catch {
            fatalError("Couldn't load or parse \(filename): \(error)")
        }
    }
    
    func saveToDisk() {
        let wrapper = ModelData(items: items, categories: categories)
        do {
            let data = try JSONEncoder().encode(wrapper)
            // .atomic - crash and wont leave half-written file
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Save failed: \(error)")
        }
    }
}


