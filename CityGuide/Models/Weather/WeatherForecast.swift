//
//  WeatherForecast.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

struct WeatherRawForecast: Codable {
    let list: [WeatherForecast]
}

struct WeatherForecast: Codable {
    let temperature: Temperature
    let wind: Wind
    let weather: [Weather]
 
    enum CodingKeys: String, CodingKey {
        case temperature = "main"
        case wind        = "wind"
        case weather     = "weather"
    }
}

struct Temperature {
    let minimal: Double
    let maximal: Double
    let average: Double
    
}

extension Temperature: Codable {
    enum CodingKeys: String, CodingKey {
        case minimal = "temp_min"
        case maximal = "temp_max"
        case average = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minimal = try container.decode(Double.self, forKey: .minimal)
        self.maximal = try container.decode(Double.self, forKey: .maximal)
        self.average = try container.decode(Double.self, forKey: .average)
    }
}

struct Weather {
    let description: String
    let conditions: String
}

extension Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case conditions  = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description).firstUppercased
        self.conditions = try container.decode(String.self, forKey: .conditions).firstUppercased
    }
}
