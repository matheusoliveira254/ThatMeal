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
        youtubeLinkTextView.isEditable = false
        youtubeLinkTextView.isSelectable = true
        if let mealName = mealToReceive {
            viewModel.loadRecipe(recipeName: mealName) {
                let attributedString = NSMutableAttributedString(string: "Watch Recipe On Youtube")
                attributedString.addAttribute(.link, value: self.viewModel.recipe.first?.youtube, range: NSRange(location: 19, length: 55))
                self.youtubeLinkTextView.attributedText = attributedString
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard UIApplication.shared.canOpenURL(URL) else {showError("Invalid Youtube Link."); return false}
        
        UIApplication.shared.open(URL)
        return false
    }
    
    private func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func populateView() {
        guard let recipe = viewModel.recipe.first,
              let mealName = recipe.meal,
              let mealNationality = recipe.area else {return}
        
        fetchImage(url: recipe.thumb)
        makeRounded()
        mealNameAndNationalityLabel.text = "\(mealName)(\(mealNationality))"
        mealCategoryLabel.text = recipe.category
        mealInstructionsLabel.text = recipe.instructions
//        youtubeLinkTextView.text = recipe.youtube
        ingredientsAndMeasuresLabel.text = recipe.ingredientsString
    }
    
    func fetchImage(url: String?) {
        guard let imageURL = URL(string: url ?? "Empty image URL") else {return}
        mealImageImageView.fetch(using: imageURL)
    }
    
    func makeRounded() {
        mealImageImageView.layer.cornerRadius = 20
        mealImageImageView.clipsToBounds = true
    }
}//End of Class
