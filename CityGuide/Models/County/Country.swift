//
//  City.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation
import CoreLocation

final class Country {
    let title: String
    let capital: String
    let region: String
    let subregion: String
    let population: Int
    let borders: [String]
    let coordinates: [Double]
    let flagPath: String
    
    var location: CLLocation {
        return CLLocation(latitude: coordinates[0], longitude: coordinates[1])
    }
    
    init(title: String, capital: String, region: String, subregion: String, population: Int, borders: [String], flagPath: String, coordinates: [Double]) {
        self.title = title
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.population = population
        self.borders = borders
        self.coordinates = coordinates
        self.flagPath = flagPath
    }
}

extension Country: Codable {
    enum CodingKeys: String, CodingKey {
        case title   = "name"
        case capital = "capital"
        case region  = "region"
        case population = "population"
        case subregion = "subregion"
        case borders    = "borders"
        case coordinates = "latlng"
        case flagPath = "flag"
    }
}



