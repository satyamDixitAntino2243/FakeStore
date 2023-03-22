//
//  Alert.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit


class AlertViewController: UIViewController {
    
    static let alertVCShared = AlertViewController()
    
    func showErrorAlert(){
        let alertView = UIAlertController(title: "OOps!!!", message: "Something Wrong Happended,Please Restart Application", preferredStyle: UIAlertController.Style.alert)
        self.present(alertView, animated: true)
    }
}

