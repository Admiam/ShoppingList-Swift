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
    @Published var lists: [ShoppingList] = []
    
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
    
    func addList(title: String) {
        let new = ShoppingList(id: .init(), title: title, items: [])
        lists.append(new)
        saveToDisk()
    }
    
    func addItem(_ name: String, to list: ShoppingList, in categoryKey: String) {
        guard let listIdx = lists.firstIndex(of: list) else { return }
        let item = Item(id: .init(), name: name, isBought: false, category: categoryKey)
        lists[listIdx].items.append(item)
        saveToDisk()
    }
    
    func toggleBought(_ item: Item, in list: ShoppingList){
        guard let listIdx = lists.firstIndex(of: list),
              let itemIdx = lists[listIdx].items.firstIndex(where: { $0.id == item.id }) else { return }
        lists[listIdx].items[itemIdx].isBought.toggle()
        saveToDisk()
    }
    
    func deleteList(_ list: ShoppingList){
        lists.removeAll { $0.id == list.id}
        saveToDisk()
    }
    
    func deleteItem(_ item: Item, from list: ShoppingList) {
        guard let lIdx = lists.firstIndex(of: list) else { return }
        lists[lIdx].items.removeAll { $0.id == item.id }
        saveToDisk()
    }
    
    func rename(_ item: Item, in list: ShoppingList, newName: String) {
        guard let listIdx = lists.firstIndex(of: list),
              let itemIdx = items.firstIndex(where: { $0.id == item.id }) else { return }
        lists[listIdx].items[itemIdx].name = newName
        saveToDisk()
    }
    
    func loadFromDisk() {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let loadedItems = try decoder.decode(ModelData.self, from: data)
//            self.items = loadedItems.items
//            self.categories = loadedItems.categories
        guard let data = try? Data(contentsOf: fileURL) else { return }
        lists = (try? JSONDecoder().decode([ShoppingList].self, from: data)) ?? []
//        } catch {
//            print("Error loading data from disk. Starting with empty store.")
////            self.categories = []
//            self.items = []
//        }
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
        if let data = try? JSONEncoder().encode(lists) {
            try? data.write(to: fileURL, options: [.atomic, .completeFileProtection])  
        }
//        let wrapper = ModelData(items: items, categories: categories)
//        do {
//            let data = try JSONEncoder().encode(wrapper)
//            // .atomic - crash and wont leave half-written file
//            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Save failed: \(error)")
//        }
    }
}


