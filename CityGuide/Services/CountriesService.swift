//
//  CountriesService.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation


class CountriesService {
    
    static func loadAllCountriea(handler: @escaping (Result<[Country], Error>) -> Void) {
        let countriesURL = URL(string: "https://restcountries.eu/rest/v2")!
        URLSession.shared.dataTask(with: countriesURL) { (data, response, error) in
            guard let data = data else { handler(.failure(error!)); return }
            let models = try? JSONDecoder().decode([Country].self, from: data)
            print(models?.count ?? 0)
            handler(.success(models ?? []))
        }.resume()
    }
}
