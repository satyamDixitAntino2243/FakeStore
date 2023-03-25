//
//  AddProductViewModel.swift
//  FakeStore
//
//  Created by satyam dixit on 25/03/23.
//

import Foundation

final class AddProductViewModel {
    
    var products: [Product]?
    var eventHandler: ((_ event: Event) -> Void)?  // DataBinding
    
    //MARK: - Fetching API Response From APIManager.
    func addProductApi(title: String?, price: Int?, description: String?, image: String?, category: String?) {
        self.eventHandler?(.loading)
        APIManager.shared.addProducts(title: title, price: price, description: description, image: image, category: category) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
