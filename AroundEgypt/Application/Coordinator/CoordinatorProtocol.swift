//
//  CoordinatorProtocol.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation


protocol CoordinatorProtocol {
    
    associatedtype PresentingView
    var view: PresentingView? { get set }
}
