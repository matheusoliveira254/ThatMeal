//
//  RecipeViewModel.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import Foundation

protocol RecipeViewModelDelegate: AnyObject {
    func populateView()
}

class RecipeViewModel {
    private let recipeService: RecipeServiceable
    weak var delegate: RecipeViewModelDelegate?
    var recipe: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.populateView()
            }
        }
    }
    
    init(recipeService: RecipeServiceable = RecipeService(), delegate: RecipeViewModelDelegate) {
        self.recipeService = recipeService
        self.delegate = delegate
    }
    
    func loadRecipe(recipeName: String, completion: @escaping () -> Void) {
        recipeService.fetchRecipe(with: recipeName) { [weak self] result in
            switch result {
            case .success(let recipe):
                self?.recipe = recipe.meals
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)
            }
        }
    }
}//End of class
