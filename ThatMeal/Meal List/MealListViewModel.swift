//
//  MealListViewModel.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import Foundation

protocol MealListViewModelDelegate: AnyObject {
    func updateView()
}

class MealListViewModel {
    private let mealListService: MealListServiceable
    weak var delegate: MealListViewModelDelegate?
    var meals: [Meal] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateView()
            }
        }
    }
    

    init(mealListService: MealListServiceable = MealListService(), delegate: MealListViewModelDelegate) {
        self.mealListService = mealListService
        self.delegate = delegate
    }
    
    func loadMealsInCategory(category: String) {
        mealListService.fetchMealsInCategories(with: category) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.meals = []
                self?.meals.append(contentsOf: meals.meals)
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)
            }
        }
    }
}//End of class
