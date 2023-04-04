//
//  APIManager.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import Foundation
import Alamofire

class APIManager {
    func sendRequest<T, U>(with target: T, decodeType: U.Type, completion: @escaping (Result<U>) -> ()) where T: Provider, U: Decodable {
        guard let url = URL(string: target.baseURL + target.path) else { return }
        AF.request(url, method: target.method, parameters: target.params, encoding: URLEncoding.default, headers: target.headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else { return }
                    print(try JSONSerialization.jsonObject(with: data))
                    let json = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
