//
//  Weather.swift
//  WeatherApp
//
//  Created by Art on 30.08.2021.
//

import Foundation
import SwiftyJSON
import Firebase

class Weather: Comparable {
    static func < (lhs: Weather, rhs: Weather) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.date == rhs.date
    }
    
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
    
    init?(_ snap: QueryDocumentSnapshot) {
        let data = snap.data()
        let dt = data["date"] as! Timestamp
        self.date = dt.dateValue()
        self.temperature = data["temperature"] as! Double
        self.pressure = data["pressure"] as! Double
        self.icon = data["icon"] as! String
        self.textDiscription = data["textDiscription"] as! String
    }
    
    func toFirestore() -> [String: Any] {
        ["date": date,
         "temperature": temperature,
         "pressure": pressure,
         "icon": icon,
         "textDiscription": textDiscription]
    }
}
