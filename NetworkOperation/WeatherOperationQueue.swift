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
        let parseWeather = ParseWeatherOperation { weather in
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
        let parseCity = ParseCityOperation {weather, city in
            OperationQueue.main.addOperation {
                completion(weather, city)
            }
        }

        let operations = [getWeather, parseCity]
        parseCity.addDependency(getWeather)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
