//
//  ProductDetailsViewModel.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import Foundation

final class ProductDetailsViewModel {
    
    var products: Product?
    var eventHandler: ((_ event: Event) -> Void)?  // DataBinding
    
    //MARK: - Fetching API Response From APIManager.
    func fetchProductDetailsApi(id: Int) {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProductsDetails(completion: { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }, id: id)
    }
}
