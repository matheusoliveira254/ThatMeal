//
//  Recipe.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

struct TopLevelDictionaryRecipe: Decodable {
    let meals: [Recipe]
}

struct Recipe {
    let meal: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumb: String?
    let youtube: String?
    let ingredients: [Ingredient]
    
    var ingredientsString: String {
        var result: String = ""
        ingredients.forEach {
            let ingredientPairString = "\($0.name) : \($0.measurement)\n"
            result.append(ingredientPairString)
        }
        return result
    }
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}

extension Recipe: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case meal = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumb = "strThumb"
        case youtube = "strYoutube"
        case ingredients
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.meal = try? container?.decode(String.self, forKey: .meal)
        self.category = try? container?.decode(String.self, forKey: .category)
        self.area = try? container?.decode(String.self, forKey: .area)
        self.instructions = try? container?.decode(String.self, forKey: .instructions)
        self.thumb = try? container?.decode(String.self, forKey: .thumb)
        self.youtube = try? container?.decode(String.self, forKey: .youtube)
        
        let ingredientNamesContainer = try? decoder.container(keyedBy: IngredientCodingKeys.self)
        let measurementsContainer = try? decoder.container(keyedBy: MeasurementsCodingKeys.self)
        let ingredients: [Ingredient] = IngredientCodingKeys.allCases.enumerated().compactMap {
            guard let name = try? ingredientNamesContainer?.decode(String.self, forKey: $0.element),
                  let measurement = try? measurementsContainer?.decode(String.self, forKey: MeasurementsCodingKeys.allCases[$0.offset]),
                  !name.isEmpty,
                  !measurement.isEmpty
            else { return nil }
            
            return Ingredient(name: name, measurement: measurement)
        }
        self.ingredients = ingredients
    }
    
    private enum IngredientCodingKeys: String, CodingKey, CaseIterable {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
    }
    
    private enum MeasurementsCodingKeys: String, CodingKey, CaseIterable {
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
}
