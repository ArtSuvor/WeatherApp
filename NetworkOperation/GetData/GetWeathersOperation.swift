//
//  GetWeathersOperation.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Alamofire
import Foundation

final class GetWeatherOperation: AsyncOperation {
    private var request: DataRequest?
    var data: Data?
    var error: Error?
    let city: String
    
    init(city: String) {
        self.city = city
    }
    
    override func main() {
        request = AF.request(WeatherRouter.getWeather(city))
            .response(queue: .global()) {[weak self] response in
            guard let self = self else { return }
            self.data = response.data
            self.error = response.error
            self.state = .finished
        }
    }
    
    override func cancel() {
        super.cancel()
        request?.cancel()
    }
}
