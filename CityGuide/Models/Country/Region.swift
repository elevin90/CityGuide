//
//  File.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

struct Region {
    
    let title: String
    let countries: [Country]
    let imageTitle: String
    
    enum RegionType: String {
        case Europe  = "Europe"
        case America = "America"
        case Asia    = "Asia"
        case Africa  = "Africa"
    }
}
