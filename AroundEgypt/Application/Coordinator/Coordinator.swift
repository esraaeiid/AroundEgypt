//
//  Coordinator.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import UIKit


class Coordinator: NSObject {
    
    
    func restart(){
        let scene = ViewController()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window = UIWindow()
        delegate?.window?.rootViewController = scene
        delegate?.window?.makeKeyAndVisible()
    }
    
    func networkFail(){
        
    }
    

}



//MARK: - Coordinator Singletone
extension Coordinator {
    struct Static {
        static var instance: Coordinator?
    }
    
    class var instance: Coordinator {
        if Static.instance == nil {
            Static.instance = Coordinator()
        }
        return Static.instance!
    }
    
}
