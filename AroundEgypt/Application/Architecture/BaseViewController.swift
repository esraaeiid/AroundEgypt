//
//  BaseViewController.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import UIKit
import Combine

class BaseViewController<T: BaseViewModel>: UIViewController {

    //MARK: Vars
    var viewModel: T?
    var cancellable: [AnyCancellable] = []
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @objc dynamic func bind() {
        
    }
    

}
