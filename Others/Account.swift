//
//  Account.swift.swift
//  WeatherApp
//
//  Created by Art on 25.08.2021.
//

import Foundation

//Singleton

class Account {
    private init(){}
    static let shared = Account()
    
    //MARK: - User info
    var name = "Ivan Pov"
    var id = 0
    var appID = "cbba7640b7037a09c4160ce42b04deec"
    let baseUrl = "https://api.openweathermap.org"
}
