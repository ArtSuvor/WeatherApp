//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Art on 27.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

protocol NetworkService {
    func getCurrentWeatherForecast(city: String, _: @escaping () -> Void)
}

class NetworkServiceImplementation: NetworkService {

    private let host = "https://api.openweathermap.org"
    
    let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()
    
    func getCurrentWeatherForecast(city: String, _: @escaping () -> Void) {
        let path = "/data/2.5/forecast"
        let params: Parameters = ["q": "\(city)",
                                  "units": "metric",
                                  "appid": Account.shared.appID]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                let forecastList = json["list"].arrayValue
                let weatherForecast = forecastList.map({ Weather($0) })
                let weatherRealmForecast = weatherForecast.map {RealmWeather($0)}
                weatherRealmForecast.forEach {$0.city = city}
                self.saveWeatherData(weatherRealmForecast, city: city)
            }
        }
    }
    
    func saveWeatherData(_ weather: [RealmWeather], city: String) {
        do {
            let realm = try Realm()
            let oldWeathers = realm.objects(RealmWeather.self).filter("city == %@", city)
            try realm.write {
                realm.delete(oldWeathers)
                realm.add(weather)
            }
            print(realm.configuration.fileURL)
        } catch let error {
            print(error)
        }
    }
}

//    struct Forecast: Codable {
//        let base: String
//        let date: Int
//        let systemInformation: SystemInformation
//        let weatherItems: [Weather]
//
//        enum CodingKeys: String, CodingKey {
//            case date = "dt"
//            case base
//            case systemInformation = "sys"
//            case weatherItems = "weather"
//        }
//
//        struct SystemInformation: Codable {
//            let id: Int
//            let country: String
//        }
//
//        struct Weather: Codable {
//            let id: Int
//            let main: String
//            let description: String
//            let icon: String
//        }
//    }

///в случае, если не знаем что парсить

//struct UnknownState {
//    let intValue: Int?
//    let stringValue: String?
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let integerValue = try? container.decode(Int.self) {
//            self.intValue = integerValue
//            self.stringValue = nil
//            return
//        } else if let stringValue = try? container.decode(String.self) {
//            self.stringValue = stringValue
//                    self.intValue = nil
//                    return
//        }
//        intValue = nil
//        stringValue = nil
//    }


//    //сессию можно настраивать, выставлять различные параметры
//    let session: URLSession = {
//        let config = URLSessionConfiguration.default
//        return URLSession(configuration: config)
//    }()
//
//    func getCurrentWeatherForecast(city: String = "Moscow") {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.openweathermap.org"
//        urlComponents.path = "/data/2.5/weather"
//        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
//                                    URLQueryItem(name: "units", value: "metric"),
//                                    URLQueryItem(name: "appid", value: Account.shared.appID)]
//        guard let url = urlComponents.url else {return}
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//
//        let task = session.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {return}
//            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//        }
//        task.resume()
//    }
    
