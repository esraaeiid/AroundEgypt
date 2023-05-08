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
        if Reachability.isConnectedToNetwork() {
            let model = ExperienceModelEnvironmentObject(experienceID: id)
            let experienceVC = UIHostingController(rootView: ExperienceScreen(model: model))
            view?.present(experienceVC, animated: true)
        }
    }

}

