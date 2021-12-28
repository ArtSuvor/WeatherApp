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
    func getCurrentWeatherForecast(city: String)
}

class NetworkServiceImplementation: NetworkService {

    private let host = "https://api.openweathermap.org"
    
    let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()
    
    func getCurrentWeatherForecast(city: String) {
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
                let forecastList = json["list"].arrayValue
                let weather = forecastList
                    .map { Weather($0) }
                    .map { $0.toFirestore() }
                    .reduce([:]) { $0.merging($1) { (current, _) in current } }
                database.collection("forecast").document(city).setData(weather, merge: true) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Data saved")
                    }
                }
            }
        }
    }
}
