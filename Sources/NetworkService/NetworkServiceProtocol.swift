//
//  NetworkServiceProtocol.swift
//  NetworkService
//
//  Created by Nkhorbaladze on 11.11.24.
//

import Foundation

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        decoder: JSONDecoder
    ) async throws -> T
}
