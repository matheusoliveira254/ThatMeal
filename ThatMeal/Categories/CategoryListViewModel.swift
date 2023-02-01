//
//  MealCategoryListViewModel.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

protocol CategoryListViewModelDelegate: AnyObject {
    func updateView()
}

class CategoryListViewModel {
    private let categoriesService: CategoriesServiceable
    weak var delegate: CategoryListViewModelDelegate?
    var categoryName: [Category] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateView()
            }
        }
    }
    
    init(categoriesService: CategoriesServiceable = CategoriesService(), delegate: CategoryListViewModelDelegate) {
        self.categoriesService = categoriesService
        self.delegate = delegate
    }
    
    func loadCategoryNames() {
        categoriesService.fetchCategoriesName { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categoryName = []
                self?.categoryName.append(contentsOf: categories.categories)
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)
            }
        }
    }
}//End of class
