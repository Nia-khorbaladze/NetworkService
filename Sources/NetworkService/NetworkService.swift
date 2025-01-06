//
//  NetworkService.swift
//  NetworkService
//
//  Created by Nkhorbaladze on 30.10.24.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

@available(macOS 12.0, iOS 16.0, *)
public final class NetworkService: NetworkServiceProtocol {
    public init() {}

    public func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw CustomErrors.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        urlRequest.httpBody = body

        if let _ = body, urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw CustomErrors.httpError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }

            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw CustomErrors.decodingError(underlyingError: decodingError)
        } catch {
            throw CustomErrors.requestError(underlyingError: error)
        }
    }
}
