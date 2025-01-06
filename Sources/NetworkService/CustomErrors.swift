//
//  CustomErrors.swift
//  NetworkService
//
//  Created by Nkhorbaladze on 11.11.24.
//

import Foundation

public enum CustomErrors: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(underlyingError: Error)
    case noData
    case requestError(underlyingError: Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)."
        case .decodingError(let underlyingError):
            return "Failed to decode the response: \(underlyingError.localizedDescription)"
        case .noData:
            return "No data was returned by the server."
        case .requestError(let underlyingError):
            return "An error occurred during the request: \(underlyingError.localizedDescription)"
        }
    }
}

