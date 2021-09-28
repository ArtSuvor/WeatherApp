//
//  Weather.swift
//  WeatherApp
//
//  Created by Art on 30.08.2021.
//

import Foundation
import SwiftyJSON

class Weather {
    let date: Date
    let temperature: Double
    let pressure: Double
    
    let icon: String
    let textDiscription: String
    
    var isLike = false
    var likeCount = 0
    
    init(_ json: JSON) {
        let date = json["dt"].doubleValue
        self.date = Date(timeIntervalSince1970: date)
        self.temperature = json["main"]["temp"].doubleValue
        self.pressure = json["main"]["pressure"].doubleValue
        self.icon = json["weather"][0]["icon"].stringValue
        self.textDiscription = json["weather"][0]["main"].stringValue
    }
    
    func toFirestore() -> [String: Any] {
        [String(format: "%0.f", date as CVarArg) : temperature]
    }
}


//struct Forecast: Codable {
//        let base: String
//        let date: Int
//        let systemInformation: SystemInformation
//        let weatherItems: [Weather]
//
//        enum CodingKeys: String, CodingKey {
//            case date = "dt"
//            case base
//            case systemInformation = "sys"
//            case weatherItems = "weather"
//        }
//
//        struct SystemInformation: Codable {
//            let id: Int
//            let country: String
//        }
//
//        struct Weather: Codable {
//            let id: Int
//            let main: String
//            let description: String
//            let icon: String
//        }
//    }
