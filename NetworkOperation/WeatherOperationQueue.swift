//
//  WeatherOperationQueue.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Foundation

protocol NetworkingOperation {
    func getWeather(city: String, completion: @escaping ([Weather]) -> Void)
    func getLocalWeather(lat: Int, lon: Int, completion: @escaping ([Weather], LocalCityModel) -> Void)
}

final class WeatherOperationQueue: NetworkingOperation {
    private let operationQueue = OperationQueue()
    
    func getWeather(city: String, completion: @escaping ([Weather]) -> Void) {
        let getWeather = GetWeatherOperation(city: city)
        let parseWeather = ParseWeatherOperation { weather, cities in
            OperationQueue.main.addOperation {
                completion(weather)
            }
        }
        let operation = [getWeather, parseWeather]
        parseWeather.addDependency(getWeather)
        operationQueue.addOperations(operation, waitUntilFinished: false)
    }
    
    func getLocalWeather(lat: Int, lon: Int, completion: @escaping ([Weather], LocalCityModel) -> Void) {
        let getWeather = GetLocalWeatherOperation(lat: lat, lon: lon)
        let parseWeather = ParseWeatherOperation { weathers, city in
            OperationQueue.main.addOperation {
                completion(weathers, city)
            }
        }
        let operations = [getWeather, parseWeather]
        parseWeather.addDependency(getWeather)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
