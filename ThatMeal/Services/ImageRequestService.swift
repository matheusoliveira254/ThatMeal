//
//  ImageRequestService.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import UIKit

//Async image view
class ServiceRequestImageView: UIImageView {
    private let service = APIService()
    func fetch(using url: URL) {
        let request = URLRequest(url: url)
        service.perform(request) { [weak self] result in
            switch result {
            case .failure:
                print("Error fetching Image" )
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.contentMode = .scaleToFill
                    self?.image = image
                }
            }
        }
    }
}//End of class
