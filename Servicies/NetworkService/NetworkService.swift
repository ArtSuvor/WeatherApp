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
                                  "units": "metric",
                                  "appid": Account.shared.appID]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                let database = Firestore.firestore()
                _ = json["list"].arrayValue
                    .map { Weather($0) }
                    .map { $0.toFirestore() }
                    .map { weathers in
                        DispatchQueue.global().async {
                            database.collection(city).addDocument(data: weathers) { error in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    database.collection(city).addSnapshotListener{ snap, error in
                                        if error == nil {
                                            if let data = snap?.documents {
                                                let weathers = data.compactMap {Weather($0)}
                                                DispatchQueue.main.async {
                                                    completion(weathers)
                                                }
                                                
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
}
