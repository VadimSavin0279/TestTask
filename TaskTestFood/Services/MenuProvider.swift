//
//  MenuProvider.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import Foundation
import Alamofire

protocol Provider {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var params: Parameters { get }
}

enum MenuProvider: Provider {
    case getFilm
}

extension MenuProvider {
    
    var baseURL: String {
        return "https://api.kinopoisk.dev"
    }
    
    var path: String {
        switch self {
        case .getFilm:
            return "/v1/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFilm:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders(["X-API-KEY": "NVWRGWV-ZCY4BY7-MG15C3Y-ZPWW9CR"])
    }
    
    var params: Parameters {
        switch self {
        case .getFilm:
            let types = ["movie", "tv-series", "cartoon", "tv-show", "animated-series"]
            return ["page": 1, "limit": 250, "type": types]
        }
    }
}
