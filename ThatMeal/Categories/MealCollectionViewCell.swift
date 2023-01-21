//
//  MealCollectionViewCell.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mealInCategoryImageView: ServiceRequestImageView!
    @IBOutlet weak var mealInCategoryNameLabel: UILabel!
    
    func configureCollectionViewCell(meal: Meal?) {
        guard let meal = meal else {return}
        fetchImage(for: meal)
        mealInCategoryNameLabel.text = meal.strMeal
    }
    
    func fetchImage(for meal: Meal) {
        guard let imageURL = URL(string: meal.strMealThumb ?? "Empty image URL") else {return}
        mealInCategoryImageView.fetch(using: imageURL)
    }
}//End of class
