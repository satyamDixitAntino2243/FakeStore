//
//  ProductViewModel.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)?  // DataBinding
    
    //MARK: - Fetching API Response From APIManager.
    func fetchProductApi() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
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
