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
    
    var store = ExperienceStore()

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
        self.loadCachedRecommendedExperiences()
        
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
                    self.cacheRecommendedExperiences(self.recommendedExperiencesList)
                    self.stateDidUpdateSubject.send(.show(true))
                    
                    
                    
                case .failure(let error):
                    self.syncCachedRecommendedExperiences()
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
        self.loadCachedRecentExperiences()
        
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
                    self.cacheRecentsExperiences(self.recentExperiencesList)
                    self.stateDidUpdateSubject.send(.show(true))
                    
                    
                    
                case .failure(let error):
                    self.syncCachedRecentExperiences()
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
    
    //MARK: caching
    func syncCachedRecentExperiences(){
        store.$recentExperiencesList.sink{ recents in
            self.recentExperiencesList = recents
        }.store(in: &cancellables)

    }
    
    func syncCachedRecommendedExperiences(){
        store.$recommendedExperiencesList.sink{ recommended in
            self.recommendedExperiencesList = recommended
        }.store(in: &cancellables)

    }
    
    func loadCachedRecentExperiences(){
        ExperienceStore.loadRecentExperience { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let recents):
                self.store.recentExperiencesList = recents
            }
        }
    }
    
    
    func loadCachedRecommendedExperiences(){
        ExperienceStore.loadRecommendedExperience{ result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let recommended):
                self.store.recommendedExperiencesList = recommended
            }
        }
    }

    
    func cacheRecommendedExperiences(_ experiences: [ExperienceDetailsModel]){
        if experiences != store.recommendedExperiencesList {
            print("Hello I'm going to save! 🫡")
            ExperienceStore.save(recommendedExperiences: experiences) { result in
                if case .failure(let error) = result {
                    fatalError(error.localizedDescription)
                } else if case .success(let count) = result {
                    print("RecommendedExperiences at store count! 🕵🏼‍♀️", count)
                }
            }
        }
    }
    
    func cacheRecentsExperiences(_ experiences: [ExperienceDetailsModel]){
        if experiences != store.recentExperiencesList {
            print("Hello I'm going to save! 🫡")
            ExperienceStore.save(recentExperiences: experiences) { result in
                if case .failure(let error) = result {
                    fatalError(error.localizedDescription)
                } else if case .success(let count) = result {
                    print("RecentsExperiences at store count! 🕵🏼‍♀️", count)
                }
            }
        }
    }

    
    
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
