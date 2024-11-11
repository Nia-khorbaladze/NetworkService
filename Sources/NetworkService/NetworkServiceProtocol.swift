//
//  NetworkServiceProtocol.swift
//  NetworkService
//
//  Created by Nkhorbaladze on 11.11.24.
//

import Foundation

public protocol NetworkServiceProtocol {
    func getData<T: Decodable>(urlString: String, key: String, completion: @Sendable @escaping (Result<T, Error>) -> Void)
    func getImageData(from url: URL, completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void)
}
