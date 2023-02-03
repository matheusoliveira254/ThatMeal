//
//  RecipeViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

class RecipeViewController: UIViewController, RecipeViewModelDelegate, UITextViewDelegate {

    @IBOutlet weak var mealImageImageView: ServiceRequestImageView!
    @IBOutlet weak var mealNameAndNationalityLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealInstructionsLabel: UILabel!
    @IBOutlet weak var ingredientsAndMeasuresLabel: UILabel!
    @IBOutlet weak var youtubeLinkTextView: UITextView!
    
    var viewModel: RecipeViewModel!
    var mealToReceive: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RecipeViewModel(delegate: self)
        youtubeLinkTextView.delegate = self
        if let mealName = mealToReceive {
            viewModel.loadRecipe(recipeName: mealName) 
        }
    }
    
    func updateTextView() {
        guard let path = viewModel.recipe.first?.youtube,
              let text = youtubeLinkTextView.text else {return}
              let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: text)
        let font = youtubeLinkTextView.font
        youtubeLinkTextView.attributedText = attributedString
        youtubeLinkTextView.font = font
    }
    
    func populateView() {
        guard let recipe = viewModel.recipe.first,
              let mealName = recipe.meal,
              let mealNationality = recipe.area else {return}
        
        DispatchQueue.main.async {
            self.fetchImage(url: recipe.thumb)
            self.makeRounded()
        }
        mealNameAndNationalityLabel.text = "\(mealName)(\(mealNationality))"
        mealCategoryLabel.text = recipe.category
        mealInstructionsLabel.text = recipe.instructions
        ingredientsAndMeasuresLabel.text = recipe.ingredientsString
        updateTextView()
    }
    
    func fetchImage(url: String?) {
        guard let imageURL = URL(string: url ?? "Empty image URL") else {return}
        mealImageImageView.fetch(using: imageURL)
    }
    
    func makeRounded() {
        mealImageImageView.layer.cornerRadius = 25
        mealImageImageView.clipsToBounds = true
    }
}//End of Class
