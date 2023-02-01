//
//  categoriesCollectionViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController {
    
    private var viewModel: MealCategoryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MealCategoryListViewModel(delegate: self)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel.loadCategoryNames()
        updateView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.categoryName.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = viewModel.categoryName[indexPath.row]
        cell.configureCollectionViewCell(category: category)
        return cell
    }
}//End of class

extension CategoriesCollectionViewController: MealCategoryListViewModelDelegate {
    func updateView() {
        self.collectionView.reloadData()
    }
}
