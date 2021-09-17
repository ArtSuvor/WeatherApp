//
//  City.swift
//  WeatherApp
//
//  Created by Art on 22.07.2021.
//

import UIKit
import RealmSwift

class RealmCity: Object {
    @Persisted(primaryKey: true) var name: String
    var weather = List<RealmWeather>()
    
    convenience init(name: String, weather: List<RealmWeather> = List<RealmWeather>()) {
        self.init()
        self.name = name
        self.weather = weather
    }
}
