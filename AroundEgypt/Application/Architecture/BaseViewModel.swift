//
//  BaseViewModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import UIKit
import Combine


// MARK: - ...  Base ViewModel
protocol BaseViewModelProtocol {
    associatedtype U
}

class BaseViewModel: BaseViewModelProtocol{
    typealias U = UseCase
    
    var useCase: U?
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    

    init(useCase: U) {
        self.useCase = useCase
    }
}

