//
//  UIImageView+Extension.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 07/05/2023.
//

import Foundation
import UIKit


extension UIImageView {
    func render(color: UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
