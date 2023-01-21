//
//  MealList.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

struct TopLevelDictionaryMeals: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
