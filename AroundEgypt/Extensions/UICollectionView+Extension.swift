//
//  UICollectionView+Extension.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import UIKit


extension UICollectionView {

/// SwifterSwift: Register UICollectionViewCell with .xib file using only its corresponding class.
///               Assumes that the .xib filename and cell class has the same name.
///
/// - Parameters:
///   - name: UICollectionViewCell type.
///   - bundleClass: Class in which the Bundle instance will be based on.
func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
    let identifier = String(describing: name)
    var bundle: Bundle?

    if let bundleName = bundleClass {
        bundle = Bundle(for: bundleName)
    }

    register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
}
    
    
    /// SwifterSwift: Dequeue reusable UICollectionViewCell using class name.
    ///
    /// - Parameters:
    ///   - name: UICollectionViewCell type.
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name))")
        }
        return cell
    }
    
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, withReuseId: String) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: withReuseId, for: indexPath) as? T else {
            assertionFailure("Can't dequeueReusableCell")
            return T()
        }

        return cell
    }


}
