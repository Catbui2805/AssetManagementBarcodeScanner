//
//  CategoryViewModel.swift
//  AssetManagementBarcodeScanner
//
//  Created by Nguyen Tran Cong on 1/24/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import Foundation

class CategoryViewModel {
    private var categories: [CategoryModel] = []
    
    init(_ categories: [CategoryModel]) {
        self.categories = categories
    }
    
    func update(_ categories: [CategoryModel]) {
        self.categories = categories
    }
    
    func getItem(_ index: Int) -> CategoryModel {
        return categories[index]
    }
    
    func editItem(_ index: Int, _ item : CategoryModel) {
        categories[index] = item
    }
    
    func getNumberOfCategories() -> Int {
        return categories.count
    }
    
    func addNewItem(_ category: CategoryModel) {
        categories.append(category)
    }
    
    func deleteItem(_ index: Int) {
        categories.remove(at: index)
    }
}
