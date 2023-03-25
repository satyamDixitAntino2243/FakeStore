//
//  ProductListViewController.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productTableView: UITableView!
    // MARK: - Variables
    private var viewModel = ProductViewModel()
    
    
    // MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupNavBarButton()
    }
    
    func setupNavBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
}

// MARK: - Extension Contains Binding Of Data
extension ProductListViewController {
    
    func configuration() {
        registerTableView()
        initViewModel()
        observeEvent()
    }
    
    
    func registerTableView() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    
    func initViewModel() {
        viewModel.fetchProductApi()
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
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error as Any)
                
            }
        }
    }
}



// MARK: - Table View DataSource Methods
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        vc?.id = viewModel.products[indexPath.row].id
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
        })
        deleteAction.backgroundColor = UIColor.red

        return [editAction, deleteAction]
    }
}
