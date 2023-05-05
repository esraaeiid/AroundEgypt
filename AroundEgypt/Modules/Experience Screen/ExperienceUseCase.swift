//
//  ExperienceUseCase.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation
import Combine


protocol ExperienceUseCaseType: UseCase {
    func requestExperience(_ request: Request) -> AnyPublisher<Result<ExperienceModel, APIError>, Never>
}


class ExperienceUseCase: UseCase {
    // MARK: -  Vars
    var apiClient: APIClientType

    // MARK: - Init
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }

}



// MARK: - Extension
extension ExperienceUseCase: ExperienceUseCaseType {
    
    func requestExperience(_ request: Request) -> AnyPublisher<Result<ExperienceModel, APIError>, Never> {
        return apiClient
            .execute(request)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
