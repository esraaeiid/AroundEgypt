//
//  UIFont+size.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 06/05/2023.
//

import Foundation
import UIKit

extension UIFont {
    class func GothamRoundedBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Bold", size: size) else {
            return UIFont()
        }
        return font

    }
   
    class func GothamRoundedBoldItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-BoldItalic", size: size) else {
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedBook(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Book", size: size) else {
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedBookItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-BookItalic", size: size) else {
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedLight(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Light", size: size) else {
            return UIFont()
        }
        return font

    }

    class func GothamRoundedLightItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-LightItalic", size: size) else {
            return UIFont()
        }
        return font

    }


    class func GothamRoundedMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Medium", size: size) else {
            return UIFont()
        }
        return font

    }

    
    class func GothamRoundedMediumItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-MediumItalic", size: size) else {
            return UIFont()
        }
        return font

    }


}
