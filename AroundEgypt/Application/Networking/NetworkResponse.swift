//
//  NetworkResponse.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: [Wrapped]
}
