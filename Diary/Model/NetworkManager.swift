//
//  NetworkManager.swift
//  Diary
//
//  Created by 조호준 on 2023/09/13.
//

import Foundation

final class NetworkManager<T: Decodable> {
    private init() { }
    
    private static func createRequest(for apiType: some APIType) -> Result<URLRequest, NetworkError> {
        guard var urlComponents = URLComponents(string: apiType.baseURL) else {
            return .failure(.invalidURL)
        }
        
        urlComponents.queryItems = apiType.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        return .success(URLRequest(url: url))
    }
    
    static func fetchData(for apiType: some APIType, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let request = createRequest(for: apiType)
        
        switch request {
        case .success(let request):
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(.dataTaskFail))
                    
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    
                    return
                }
                
                if let data {
                    do {
                        let result: T = try JSONDecoder().decode(T.self, from: data)
                        
                        completion(.success(result))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }
            }.resume()
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
