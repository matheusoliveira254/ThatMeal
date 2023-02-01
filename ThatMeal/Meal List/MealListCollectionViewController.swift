//
//  MealListCollectionViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class MealListCollectionViewController: UICollectionViewController {

    var viewModel: MealListViewModel!
    var categoryToReceive: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MealListViewModel(delegate: self)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if let category = categoryToReceive {
            viewModel.loadMealsInCategory(category: category)
        }
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
        return viewModel.meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealCell", for: indexPath) as! MealCollectionViewCell
        let meal = viewModel.meals[indexPath.row]
        DispatchQueue.main.async {
            cell.configureMealCollectionViewCell(meal: meal)
        }
        return cell
    }
}//End of class

extension MealListCollectionViewController: MealListViewModelDelegate {
    func updateView() {
        self.collectionView.reloadData()
    }
}
