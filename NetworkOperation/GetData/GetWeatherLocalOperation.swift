//
//  GetWeatherLocationOperation.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import Foundation
import Alamofire

class GetLocalWeatherOperation: AsyncOperation {
    private var request: DataRequest?
    var data: Data?
    var error: Error?
    
    private let latitude: Int
    private let longitude: Int
    
    init(lat: Int, lon: Int) {
        self.latitude = lat
        self.longitude = lon
    }
    
    override func main() {
        request = AF.request(WeatherRouter.getWeatherLocation(lat: latitude, long: longitude))
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
