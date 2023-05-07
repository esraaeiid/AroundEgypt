//
//  ExperienceViewModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import Combine
import UIKit

protocol ExperienceViewModelType {
    func singleExperienceRequest(with id: String)
    func likeExperienceRequest(with id: String)
}

/// define all states of view.
enum ExperienceViewModelState {
    case show(Bool)
    case error(String)
}

 
class ExperienceViewModel: BaseViewModel, ObservableObject {
    
    //MARK: Vars
    /// immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    private var cancellables: [AnyCancellable] = []
    private let stateDidUpdateSubject = PassthroughSubject<ExperienceViewModelState, Never>()
    @Published var singleExperience: ExperienceModel?
    @Published var isLiked: Bool = false

    public private(set) var hasNext: Bool = false
    private var page = 1
    
    //MARK: Init
    init(useCase: ExperienceUseCaseType) {
        super.init(useCase: useCase)
    }
    
}

//MARK: - Request

extension ExperienceViewModel: ExperienceViewModelType {
    
    //MARK: single experiences
    func singleExperienceRequest(with id: String) {
        guard let viewModelUseCase = self.useCase as? ExperienceUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.singleExperienceRequest(with: id)
        request.method = Request.Methods.get.value
        
        viewModelUseCase.requestExperience(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let experience):
                    
                    self.singleExperience = experience
                    self.stateDidUpdateSubject.send(.show(true))
                    
                    
                case .failure(let error):
                    switch error {
                    case .networkError:
                        self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                    case .requestError(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    case .unknown(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    case .parameterEncodingError:
                        self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                    }
                    
                }
            }.store(in: &cancellables)
    }
    
    
    //MARK: like experiences
    func likeExperienceRequest(with id: String) {
        guard let viewModelUseCase = self.useCase as? ExperienceUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.likeExperienceRequest(with: id)
        request.method = Request.Methods.post.value
        
        viewModelUseCase.requestExperience(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(_):
                    
                    self.isLiked = true
                    self.stateDidUpdateSubject.send(.show(true))
                   
                    
                    
                case .failure(let error):
                    switch error {
                    case .networkError:
                        self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                    case .requestError(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    case .unknown(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    case .parameterEncodingError:
                        self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                    }
                    
                }
            }.store(in: &cancellables)
    }
    
        
    
}


//MARK: - Functions

extension ExperienceViewModel {

    //MARK: single experiences
    
    func loadImage(singleExperience: ExperienceModel){
        ///Image
//        switch singleExperience.data {
//        case .experienceDetails(let experience):
//            if let url = experience.coverPhoto,
//               let experienceID = experience.id {
//                imageLoader = ImageLoader(url: url,
//                                          photoID: experienceID)
//            }
//        case .int(_):
//            break
//        case .none:
//            break
//        }
//
//        guard imageLoader != nil else {
//            return
//        }
//
//        imageLoader?.$image.sink { [weak self] img in
//            guard let self = self else { return }
//
//            if img != nil {
//                RunLoop.main.perform {
//                    self.loadedImage = img ?? UIImage()
//                    self.imageLoader = nil
//                }
//            }
//
//        }.store(in: &cancellable)
    }
    
    //MARK: like experiences
    
    

}
