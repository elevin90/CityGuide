//
//  WeatherService.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherAPI {
    func weather(for coordinates: CLLocationCoordinate2D, handler: @escaping (Result<String, Error>) -> Void)
    func image(with title: String, handler: @escaping (Result<Data, Error>) -> Void)
}

class WeatherService {
    
    private let endPoint = "http://api.openweathermap.org/"
    private let token: String
    
    init() {
        if let path = Bundle.main.path(forResource: "AppSandbox", ofType: "plist"), let keys = NSDictionary(contentsOfFile: path),
            let key = keys["WeatherKey"] as? String {
            token = key
        } else {
            token = ""
        }
    }
}

extension WeatherService: WeatherAPI {
    public  func weather(for location: CLLocationCoordinate2D, handler: @escaping (Result<String, Error>) -> Void) {
        let longtitude = location.longitude
        let latitude = location.latitude
        let url = URL(string: "\(endPoint)data/2.5/weather")
        guard let forecastURL = url else { return }
        var components = URLComponents(url: forecastURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "lat", value: String(latitude)),
                                  URLQueryItem(name: "lon", value: String(longtitude)),
                                  URLQueryItem(name: "APPID", value: token)]
        guard let requestURL = components?.url else { return }
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
          //  guard let data = data else { return }
//       let forecast = try? JSONDecoder().decode(WeatherForecast.self, from: data)
            
            handler(.success(""))
        }.resume()
    }
    
    public func image(with title: String, handler: @escaping (Result<Data, Error>) -> Void) {
        
        let url = URL(string: "\(endPoint)wn/(title).png")
        guard let pictureURL = url else { return }
        URLSession.shared.dataTask(with: pictureURL) { (data, response, error) in
            
        }
    }
}
