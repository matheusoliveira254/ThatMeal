//
//  MealCategoryListViewModel.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

protocol MealCategoryListViewModelDelegate: AnyObject {
    func updateView()
}

class MealCategoryListViewModel {
    private let categoriesService: CategoriesServiceable
    var categoryName: [Category] = []
    var meals: [Meal] = []
    weak var delegate: MealCategoryListViewModelDelegate?
    
    init(categoriesService: CategoriesServiceable = CategoriesService(), delegate: MealCategoryListViewModelDelegate) {
        self.categoriesService = categoriesService
        self.delegate = delegate
    }
    
    func loadCategoryNames() {
        categoriesService.fetchCategoriesName { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categoryName = []
                self?.categoryName.append(contentsOf: categories.categories)
//                DispatchQueue.main.async {
//                    self?.delegate?.updateViews()
//                }
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)
            }
        }
    }
    
    func loadMealsInCategory(category: String) {
        categoriesService.fetchMealsInCategories(with: category) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.meals = []
                self?.meals.append(contentsOf: meals.meals)
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)            }
        }
    }
}//End of class
