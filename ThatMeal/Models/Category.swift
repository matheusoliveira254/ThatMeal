//
//  Category.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

struct TopLevelDictionaryCategory: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let strCategory: String?
}
