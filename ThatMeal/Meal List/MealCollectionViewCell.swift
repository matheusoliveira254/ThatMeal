//
//  MealCollectionViewCell.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mealImageServiceRequestImageView: ServiceRequestImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    func configureMealCollectionViewCell(meal: Meal?) {
        guard let meal = meal else {return}
        fetchImage(for: meal)
        mealNameLabel.text = meal.strMeal
    }
    
    func fetchImage(for meal: Meal) {
        guard let imageURL = URL(string: meal.strMealThumb ?? "Empty image URL") else {return}
        mealImageServiceRequestImageView.fetch(using: imageURL)
    }
}//End of class
