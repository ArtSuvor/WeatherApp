//
//  RealmWeather.swift
//  WeatherApp
//
//  Created by Art on 09.09.2021.
//

import Foundation
import RealmSwift

class RealmWeather: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var temperature: Double = 0.0
    @Persisted var icon: String = ""
    @Persisted var textDescription: String = ""
    @Persisted var isLike: Bool = false
    
    convenience init(_ model: Weather) {
        self.init()
        self.temperature = model.temperature
        self.icon = model.icon
        self.textDescription = model.textDiscription
    }
}
