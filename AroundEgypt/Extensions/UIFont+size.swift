//
//  UIFont+size.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 06/05/2023.
//

import Foundation
import UIKit

extension UIFont {
    //MARK: GothamRounded fonts
    class func GothamRoundedBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Bold", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
   
    class func GothamRoundedBoldItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-BoldItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedBook(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Book", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedBookItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-BookItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamRoundedLight(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Light", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }

    class func GothamRoundedLightItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-LightItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }


    class func GothamRoundedMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-Medium", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }

    
    class func GothamRoundedMediumItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "GothamRounded-MediumItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }

    //MARK: Gotham fonts
    class func GothamBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-Bold", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamBoldItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-BoldItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamBook(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-Book", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamBookItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-BookItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    class func GothamLight(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-Light", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }

    class func GothamLightItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-LightItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
    
    
    class func GothamMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-Medium", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }


    class func GothamMediumItalic(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gotham-MediumItalic", size: size) else {
            assertionFailure("font not found!")
            return UIFont()
        }
        return font

    }
}
