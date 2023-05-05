//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import Combine

protocol HomeViewModelType {
    func requestExperience()
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
    @Published var experiences: [ExperienceModel.Datum] = []

    public private(set) var hasNext: Bool = false
    private var page = 1
    
    //MARK: Init
    init(useCase: HomeUseCaseType) {
        super.init(useCase: useCase)
    }
    
}

//MARK: - Request

extension HomeViewModel: HomeViewModelType {
    
    func requestExperience(){
        guard let viewModelUseCase = self.useCase as? HomeUseCaseType else { return }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        
        var request = Request.experiencesRequest()
        request.method = Request.Methods.get.value
        
        viewModelUseCase.request(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let experiences):
            
                    self.experiences += experiences.data
                    print("count⏺", self.experiences.count)
                    self.stateDidUpdateSubject.send(.show(true))
                    

                    
                case .failure(let error):
                    switch error {
                    case .networkError:
                        self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                    case .requestError(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    case .unknown(let errorDescription):
                        self.stateDidUpdateSubject.send(.error(errorDescription))
                    }
                    
                }
            }.store(in: &cancellables)
    }
    
    
}


//MARK: - Functions

extension HomeViewModel {
    
    
    //MARK: fetching experiences
    func fetchExperience(at index: Int) -> ExperienceModel.Datum? {
        if experiences.indices.contains(index) {
            return experiences[index]
        }
        return nil
    }
   
    
    func getExperiencesCount() -> Int {
        return experiences.count
    }
    

}
