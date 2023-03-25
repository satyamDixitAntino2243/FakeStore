//
//  APIManager.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> Void
typealias ProductDetailsHandler = (Result<Product, DataError>) -> Void
// Singleton Design Pattern
final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    //MARK: - Products
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.FakeStoreAPI.productListingURL) else { return }
        
        // BackGround Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            // JSONDecoder() - Data ko Model mai convert krega
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    //MARK: -- Products Details
    func fetchProductsDetails(completion: @escaping ProductDetailsHandler, id: Int) {
        guard let url = URL(string: Constant.FakeStoreAPI.productBaseURL + "/\(id)") else { return }
        
        // BackGround Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            // JSONDecoder() - Data ko Model mai convert krega
            do {
                let products = try JSONDecoder().decode(Product.self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    
    func addProducts(title: String?, price: Int?, description: String?, image: String?, category: String?, completion: @escaping Handler) {
        guard let url = URL(string: Constant.FakeStoreAPI.productListingURL) else { return }

        let parameters = [
            "title": title ?? "test product",
            "price": price ?? 13.5,
            "description": description ?? "lorem ipsum set",
            "image": image ?? "https://i.pravatar.cc",
            "category": category ?? "electronic"
        ] as [String : Any]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }

        // BackGround Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    
}
