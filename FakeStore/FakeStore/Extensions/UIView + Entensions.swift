//
//  UIView + Entensions.swift
//  FakeStore
//
//  Created by satyam dixit on 21/03/23.
//

import UIKit

extension UIView {
    func viewRoundCorners() {
        self.layer.cornerRadius = self.layer.frame.width - 20
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}

