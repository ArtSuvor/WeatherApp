//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Art on 27.08.2021.
//

import Alamofire
import SwiftyJSON
import FirebaseFirestore

protocol NetworkService {
    func getCurrentWeatherForecast(city: String, completion: @escaping ([Weather]) -> Void)
}

class NetworkServiceImplementation: NetworkService {

    private let host = "https://api.openweathermap.org"
    
    let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()
    
    func getCurrentWeatherForecast(city: String, completion: @escaping ([Weather]) -> Void) {
        let path = "/data/2.5/forecast"
        let params: Parameters = ["q": "\(city)",
                                  "cnt": "20",
                                  "units": "metric",
                                  "appid": Account.shared.appID]
        session.request(host + path, method: .get, parameters: params).response(queue: .global()) { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value as Any)
                let database = Firestore.firestore()
                _ = json["list"].arrayValue
                    .map { Weather($0) }
                    .map { $0.toFirestore() }
                    .map { weather in
                        database.collection(city)
                            .addDocument(data: weather){ error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                database.collection(city)
                                    .addSnapshotListener{ snap, error in
                                    if error == nil {
                                        if let data = snap?.documents {
                                            var weathers = data
                                                .compactMap {Weather($0)}
                                            weathers.sort()
                                            completion(weathers)
                                        }
                                    } else {
                                        print(error!.localizedDescription)
                                    }
                                }
                                
                            }
                        }
                        
                    }
            }
        }
    }
}
