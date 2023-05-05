//
//  HomeUseCase.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import Combine


protocol HomeUseCaseType: UseCase {
    func requestHome(_ request: Request) -> AnyPublisher<Result<HomeModel, APIError>, Never>
    func requestExperience(_ request: Request) -> AnyPublisher<Result<ExperienceModel, APIError>, Never>
}


class HomeUseCase: UseCase {
    // MARK: -  Vars
    var apiClient: APIClientType

    // MARK: - Init
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }

}



// MARK: - Extension
extension HomeUseCase: HomeUseCaseType {

    func requestHome(_ request: Request) -> AnyPublisher<Result<HomeModel, APIError>, Never> {
        return apiClient
            .execute(request)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func requestExperience(_ request: Request) -> AnyPublisher<Result<ExperienceModel, APIError>, Never> {
        return apiClient
            .execute(request)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
