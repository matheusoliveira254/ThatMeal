//
//  MealCollectionViewCell.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageServiceRequestImageView: ServiceRequestImageView!
    
    func configureCollectionViewCell(category: Category?) {
        guard let category = category else {return}
        DispatchQueue.main.async {
            self.fetchImage(for: category)
            self.makeRounded()
            self.categoryNameLabel.text = category.strCategory
        }
    }
    
    func fetchImage(for category: Category) {
        guard let imageURL = URL(string: category.strCategoryThumb ?? "Empty image URL") else {return}
        categoryImageServiceRequestImageView.fetch(using: imageURL)
    }
    
    func makeRounded() {
        categoryImageServiceRequestImageView.layer.cornerRadius = 45
        categoryImageServiceRequestImageView.clipsToBounds = true
    }
}//End of class
