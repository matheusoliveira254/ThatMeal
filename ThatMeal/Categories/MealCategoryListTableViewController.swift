//
//  MealCategoryListTableViewController.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import UIKit

class MealCategoryListTableViewController: UITableViewController, MealCategoryListViewModelDelegate {

    private var viewModel: MealCategoryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MealCategoryListViewModel(delegate: self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.categoryName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoriesTableViewCell
        let category = viewModel.categoryName[indexPath.row]
        cell.configureTableViewCell(with: category)
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}//End of class

extension MealCategoryListTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealInCategoryCell", for: indexPath) as! MealCollectionViewCell
        let meal = viewModel.meals[indexPath.row]
        cell.configureCollectionViewCell(meal: meal)
        return cell
    }
}

extension MealCategoryListTableViewController {
    func updateView() {
        <#code#>
    }
}
