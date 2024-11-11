//
//  CustomErrors.swift
//  NetworkService
//
//  Created by Nkhorbaladze on 11.11.24.
//

import Foundation

enum CustomErrors: Error {
    case errorResponse
    case statusCode(Int)
}
