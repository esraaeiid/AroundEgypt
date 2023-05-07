//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import Combine

protocol HomeViewModelType {
    func recommendedExperiencesRequest()
    func recentExperiencesRequest()
    func searchExperiencesRequest(with title: String)
    func likeExperienceRequest(with id: String)
}

/// define all states of view.
enum HomeViewModelState {
    case show(Bool)
    case error(String)
}

 
class HomeViewModel: BaseViewModel {
    
    //MARK: Vars
    /// immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    private var cancellables: [AnyCancellable] = []
    private let stateDidUpdateSubject = PassthroughSubject<HomeViewModelState, Never>()
    @Published var recommendedExperiencesList: [ExperienceDetailsModel] = []
    @Published var recentExperiencesList: [ExperienceDetailsModel] = []
    @Published var searchExperiencesList: [ExperienceDetailsModel] = []
    @Published var isLiked: Bool = false

    public private(set) var hasNext: Bool = false
    private var page = 1
    
    //MARK: Init
    init(useCase: HomeUseCaseType) {
        super.init(useCase: useCase)
    }
    
}

//MARK: - Request

extension HomeViewModel: HomeViewModelType {
    
    //MARK: recommended experiences
    func recommendedExperiencesRequest() {
        guard let viewModelUseCase = self.useCase as? HomeUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.experiencesRequest()
        request.method = Request.Methods.get.value
        request.param = ["filter[recommended]" : true]
        
        viewModelUseCase.requestHome(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let experiences):
                    
                    self.recommendedExperiencesList += experiences.data ?? []
                    print("count⏺", self.recommendedExperiencesList.count)
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
    
    //MARK: recent experiences
    func recentExperiencesRequest() {
        guard let viewModelUseCase = self.useCase as? HomeUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.experiencesRequest()
        request.method = Request.Methods.get.value
        
        viewModelUseCase.requestHome(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let experiences):
                    
                    self.recentExperiencesList += experiences.data ?? []
                    print("count⏺", self.recentExperiencesList.count)
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
    
    //MARK: search experiences
    func searchExperiencesRequest(with title: String) {
        guard let viewModelUseCase = self.useCase as? HomeUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.experiencesRequest()
        request.method = Request.Methods.get.value
        request.param = ["filter[title]" : title ]
        
        viewModelUseCase.requestHome(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let experiences):
                    
                    self.searchExperiencesList += experiences.data ?? []
                    print("count⏺", self.searchExperiencesList.count)
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
        guard let viewModelUseCase = self.useCase as? HomeUseCaseType else { return }
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

extension HomeViewModel {
    
    
    //MARK: recommended experiences
    func fetchRecommendedExperience(at index: Int) -> ExperienceDetailsModel? {
        if recommendedExperiencesList.indices.contains(index) {
            return recommendedExperiencesList[index]
        }
        return nil
    }
   
    
    func getRecommendedExperiencesCount() -> Int {
        return recommendedExperiencesList.count
    }
    
    //MARK: recent experiences
    func fetchRecentExperience(at index: Int) -> ExperienceDetailsModel? {
        if recentExperiencesList.indices.contains(index) {
            return recentExperiencesList[index]
        }
        return nil
    }
   
    
    func getRecentExperiencesCount() -> Int {
        return recentExperiencesList.count
    }
    
    
    //MARK: search experiences
    func fetchSearchExperience(at index: Int) -> ExperienceDetailsModel? {
        if searchExperiencesList.indices.contains(index) {
            return searchExperiencesList[index]
        }
        return nil
    }
   
    
    func getSearchExperiencesCount() -> Int {
        return searchExperiencesList.count
    }
    
    
    //MARK: like experiences
    

}
