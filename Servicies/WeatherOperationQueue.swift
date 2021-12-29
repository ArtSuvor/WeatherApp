//
//  WeatherOperationQueue.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Foundation

final class WeatherOperationQueue {
    private let operationQueue = OperationQueue()
    
    func getWeather(city: String, completion: @escaping ([Weather]) -> Void) {
        let getWeather = GetWeatherOperation(city: city)
        let parseWeather = ParseWeatherOperation { weather in
            OperationQueue.main.addOperation {
                completion(weather)
            }
        }
        let operation = [getWeather, parseWeather]
        parseWeather.addDependency(getWeather)
        operationQueue.addOperations(operation, waitUntilFinished: false)
    }
}
