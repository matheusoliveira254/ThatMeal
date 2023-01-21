//
//  CategoriesTableViewCell.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configureTableViewCell(with category: Category?) {
        guard let category = category else {return}
        categoryNameLabel.text = category.strCategory
    }
}
