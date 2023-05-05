//
//  HomeCoordinator.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import SwiftUI

class HomeCoordinator: Coordinator, CoordinatorProtocol {
    typealias PresentingView = HomeViewController

    weak var view: PresentingView?
    
    deinit {
        self.view = nil
    }
    
}


extension HomeCoordinator {
   
    func presentExperience(with id: String){
       let experienceVC = UIHostingController(rootView: ExperienceScreen())
        view?.present(experienceVC, animated: true)
    }

}

