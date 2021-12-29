//
//  ParseWeatherOperation.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Foundation
import SwiftyJSON
import FirebaseFirestore

final class ParseWeatherOperation: AsyncOperation {
    private let completion: ([Weather]) -> Void
    
    init(completion: @escaping ([Weather]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getWeather = dependencies.first as? GetWeatherOperation,
              let dataWeather = getWeather.data else { return }
        let city = getWeather.city
        let json = JSON(dataWeather)
        let weatherArray = json["list"].arrayValue
        _ = weatherArray
            .map { Weather($0) }
            .map { $0.toFirestore() }
            .map { weather in
                Firestore.firestore().collection(city).addDocument(data: weather) {[weak self] error in
                        guard let self = self else { return }
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            Firestore.firestore().collection(city).addSnapshotListener { snap, error in
                                    if error == nil, let data = snap?.documents {
                                            var weathers = data.compactMap { Weather($0) }
                                            weathers.sort()
                                            self.completion(weathers)
                                    } else {
                                        print(error!.localizedDescription)
                                    }
                                }
                        }
                    }
            }
    }
}
