//
//  DateFormatterD.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Foundation

class DateFormatterDate {
    
    static let shared = DateFormatterDate()
    private init() {}
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        return df
    }()
    
    func getDateString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
