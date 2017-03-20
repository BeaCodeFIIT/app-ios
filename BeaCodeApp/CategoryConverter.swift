//
//  CategoryConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public class CategoryConverter {
    //CategoryDto -> Category
    
    static let shared = CategoryConverter()
    
    func convert(input: CategoryDto) -> Category? {
        
        var category = Category()
        category.id = input.id
        category.name = input.name
        
        return category
    }
}
