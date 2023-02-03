//
//  categoriesCollectionViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController {
    
    private var viewModel: CategoryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CategoryListViewModel(delegate: self)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel.loadCategoryNames()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toMealListVC",
              let index = collectionView.indexPathsForSelectedItems?.first,
              let destination = segue.destination as? MealListCollectionViewController else {return}
        let category = viewModel.categoryName[index.item]
        let categoryToSend = category.strCategory
        destination.categoryToReceive = categoryToSend
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryName.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = viewModel.categoryName[indexPath.row]
        DispatchQueue.main.async {
            cell.configureCollectionViewCell(category: category)
        }
        return cell
    }
}//End of class

extension CategoriesCollectionViewController: CategoryListViewModelDelegate {
    func updateView() {
        self.collectionView.reloadData()
    }
}
