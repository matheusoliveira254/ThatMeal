//
//  RecipeViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

class RecipeViewController: UIViewController, RecipeViewModelDelegate {

    @IBOutlet weak var mealImageImageView: ServiceRequestImageView!
    @IBOutlet weak var mealNameAndNationalityLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealInstructionsLabel: UILabel!
    @IBOutlet weak var ingredientsAndMeasuresLabel: UILabel!
    @IBOutlet weak var youtubeLinkTextView: UITextView!
    
    var viewModel: RecipeViewModel!
    var mealToReceive: String?
    let ingredientCount = 20
    var ingredientsAndMeasuresText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RecipeViewModel(delegate: self)
        if let mealName = mealToReceive {
            viewModel.loadRecipe(recipeName: mealName)
        }
    }
    
    func populateView() {
        guard let recipe = viewModel.recipe.first else {return}
        fetchImage(url: recipe.strThumb)
        mealNameAndNationalityLabel.text = "\(recipe.strMeal)(\(recipe.strArea))"
        mealCategoryLabel.text = recipe.strCategory
        mealInstructionsLabel.text = recipe.strInstructions
        youtubeLinkTextView.text = recipe.strYoutube
        addIngredientsToVar {
            self.ingredientsAndMeasuresLabel.text = self.ingredientsAndMeasuresText
        }
    }
    
    func addIngredientsToVar(completion: @escaping () -> Void) {
        guard let recipe = viewModel.recipe.first else {return}
        
    }
    
    func fetchImage(url: String?) {
        guard let imageURL = URL(string: url ?? "Empty image URL") else {return}
        mealImageImageView.fetch(using: imageURL)
    }
}//End of Class
