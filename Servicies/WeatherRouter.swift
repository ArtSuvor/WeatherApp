//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Alamofire
import Foundation

enum WeatherRouter: URLRequestConvertible {
    case getWeather(_ city: String)
    
    private var token: String {
        return Account.shared.appID
    }
    
    private var url: URL {
        URL(string: Account.shared.baseUrl)!
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getWeather: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getWeather: return "/data/2.5/forecast"
        }
    }
    
    private var params: Parameters {
        switch self {
        case .getWeather(let city):
            return ["q": "\(city)",
                    "cnt": "20",
                    "units": "metric",
                    "appid": "\(Account.shared.appID)"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return try URLEncoding.default.encode(request, with: params)
    }
}
