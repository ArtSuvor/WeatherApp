//
//  LocalCityModel.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import Foundation
import SwiftyJSON

class LocalCityModel {
    let name: String
    let coord: Coord
    
    struct Coord {
        let lat: Int
        let lon: Int
        
        init(_ json: JSON) {
            self.lat = json["city"]["coord"]["lat"].intValue
            self.lon = json["city"]["coord"]["lon"].intValue
        }
    }
    
    init(_ json: JSON) {
        self.name = json["city"]["name"].stringValue
        self.coord = Coord(json)
    }
}
