//
//  RecipeViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var mealImageImageView: UIImageView!
    @IBOutlet weak var mealNameAndNationalityLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealInstructionsLabel: UILabel!
    @IBOutlet weak var ingredientsAndMeasuresLabel: UILabel!
    @IBOutlet weak var youtubeLinkTextView: UITextView!
    
    private var viewModel: RecipeViewModel!
    var mealToReceive: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RecipeViewModel(delegate: self)
        if let mealName = mealToReceive {
            viewModel.loadRecipe(recipeName: mealName)
        }
    }

}//End of Class

extension RecipeViewController: RecipeViewModelDelegate {
    func updateView() {
    
    }
}
