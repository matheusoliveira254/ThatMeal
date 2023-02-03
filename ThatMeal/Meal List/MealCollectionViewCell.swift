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
        DispatchQueue.main.async {
            self.fetchImage(for: meal)
            self.makeRounded()
            self.mealNameLabel.text = meal.strMeal
        }
    }
    
    func fetchImage(for meal: Meal) {
        guard let imageURL = URL(string: meal.strMealThumb ?? "Empty image URL") else {return}
        mealImageServiceRequestImageView.fetch(using: imageURL)
    }
    
    func makeRounded() {
        mealImageServiceRequestImageView.layer.cornerRadius = 45
        mealImageServiceRequestImageView.clipsToBounds = true
    }
}//End of class
