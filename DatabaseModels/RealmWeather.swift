//
//  RealmWeather.swift
//  WeatherApp
//
//  Created by Art on 09.09.2021.
//

import Foundation
import RealmSwift

class RealmWeather: Object {
    @Persisted var temperature: Double = 0.0
    @Persisted var icon: String = ""
    @Persisted var textDescription: String = ""
    @Persisted var city = ""
    
    convenience init(_ model: Weather) {
        self.init()
        self.temperature = model.temperature
        self.icon = model.icon
        self.textDescription = model.textDiscription
        self.city = city
    }
}
