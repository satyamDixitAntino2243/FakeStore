//
//  ProductCell.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

class ProductCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - Propety Observer for setting product
    var product: Product? {
        didSet {
            productDetailsConfiguration()
        }
    }
    
    //MARK: - For Cell UI Elements Updation
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Products items Configuration
    func productDetailsConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        productDescriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle(" \(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image )
    }
    
}
