//
//  ProductDetailsViewController.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    //MARK: -- IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    static let identifier = "ProductDetailsViewController"
    // MARK: - Variables
    private var viewModel = ProductDetailsViewModel()
    var id: Int = 1
    
    // MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        configuration()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.productDetailsConfiguration()
    }

}


extension ProductDetailsViewController {
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProductDetailsApi(id: id)
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
//                    self.viewModel.products
                }
            case .error(let error):
                print(error as Any)
                
            }
        }
    }
    
    //MARK: - Products items Configuration
    func productDetailsConfiguration() {
        self.productTitleLabel.text = self.viewModel.products?.title
        productCategoryLabel.text = viewModel.products?.category
        productDescriptionLabel.text = viewModel.products?.description
        priceLabel.text = "$\(String(describing: viewModel.products?.price))"
        rateButton.setTitle(" \(String(describing: viewModel.products?.rating.rate))", for: .normal)
        productImageView.setImage(with: viewModel.products?.image ?? "" )
    }
}
