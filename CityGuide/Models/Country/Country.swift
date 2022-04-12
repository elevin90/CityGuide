//
//  City.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation
import CoreLocation

struct Country {
    let title: String
    let capital: String
    let region: String
    let subregion: String
    let population: Int
    let coordinates: [Double]
    let flagPath: String
    
    var location: CLLocation {
        guard coordinates.count > 1 else {
            return CLLocation()
        }
        return CLLocation(latitude: coordinates[0], longitude: coordinates[1])
    }
    
    init(with savedCountry: SavedCountry) {
        title = savedCountry.title ?? ""
        capital = savedCountry.capital ?? ""
        region = savedCountry.country?.title ?? ""
        subregion = ""
        population = 0
        coordinates = [0, 0]
        flagPath = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        capital = try container.decodeIfPresent(String.self, forKey: .capital) ?? "No capital"
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "No Title"
        self.region = try container.decodeIfPresent(String.self, forKey: .region) ?? "No Region"
        self.subregion = try container.decodeIfPresent(String.self, forKey: .subregion) ?? "No subregion"
        self.population = try container.decodeIfPresent(Int.self, forKey: .population) ?? 0
        self.coordinates = try container.decodeIfPresent([Double].self, forKey: .coordinates) ?? [0, 0]
        self.flagPath = try container.decodeIfPresent(String.self, forKey: .flagPath) ?? ""
    }
}

extension Country: Codable {
    enum CodingKeys: String, CodingKey {
        case title   = "name"
        case capital = "capital"
        case region  = "region"
        case population = "population"
        case subregion = "subregion"
        case coordinates = "latlng"
        case flagPath = "flag"
    }
}



