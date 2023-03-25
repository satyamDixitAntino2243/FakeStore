//
//  ProductDetailsViewController.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    //MARK: -- IBOutlets
    @IBOutlet weak var productDetailsTitleLabel: UILabel?
    @IBOutlet weak var productDetailsCategoryLabel: UILabel?
    @IBOutlet weak var productDescriptionDetailsLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var rateButton: UIButton?
    @IBOutlet weak var productDetailsImageView: UIImageView!
    
    static let identifier = "ProductDetailsViewController"
    // MARK: - Variables
    private var viewModel = ProductDetailsViewModel()
    var id: Int?

    // MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}


extension ProductDetailsViewController {
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProductDetailsApi(id: id ?? 1)
    }
    
    // Data Binding Event Observe Krega - Communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading: break
            case .stopLoading: break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productDetailsConfiguration(products: self.viewModel.products)
                }
            case .error(let error):
                print(error as Any)
                
            }
        }
    }
    
    //MARK: - Products items Configuration
    func productDetailsConfiguration(products: Product?) {
        productDetailsTitleLabel?.text = products?.title
        productDetailsCategoryLabel?.text = products?.category
        productDescriptionDetailsLabel?.text = products?.description
        priceLabel?.text = "$\(products?.price ?? 20)"
        rateButton?.setTitle("\(products?.rating.rate ?? 4)", for: .normal)
        productDetailsImageView?.setImage(with: products?.image ?? "" )
    }
}
