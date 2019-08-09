//
//  File.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

struct CountrySection {
    
    let title: String
    let countries: [Country]
    var isExpanded = false
    
    init(title: String, countries: [Country]) {
        self.title = title
        self.countries = countries
    }
}
