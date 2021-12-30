//
//  ParseCityOperation.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import Foundation
import SwiftyJSON

final class ParseCityOperation: AsyncOperation {
    private let completion: ([Weather], LocalCityModel) -> Void
    
    init(completion: @escaping ([Weather], LocalCityModel) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getWeather = dependencies.first as? GetLocalWeatherOperation,
              let data = getWeather.data else { return }
        let json = JSON(data)
        let city = LocalCityModel(json)
        let weather = json["list"].arrayValue
            .map { Weather($0) }
        completion(weather, city)
        state = .finished
    }
}
