//
//  NetworkService.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import Foundation

public final class NetworkService : NetworkServiceProtocol {
    
    public init() {}
    
    public func getData<T: Decodable>(urlString: String, key: String, completion: @Sendable @escaping (Result<T, Error>)->Void) {
        let url = URL(string: urlString)
        guard let url = url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(key, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(CustomErrors.errorResponse))
                return
            }
            
            print(response)
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(CustomErrors.statusCode(response.statusCode)))
                return
            }
            
            guard let data else { return }
            
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            } catch {
                print("Decoding error:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func getImageData(from url: URL, completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
