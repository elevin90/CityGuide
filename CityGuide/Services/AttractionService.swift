//
//  AttractionService.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

final class AttractionService {
    
    private let endpoint = "https://www.triposo.com/api/20181213/"
    private let token: String
    private let accountID: String
    
    static let shared = AttractionService()
    
    private init() {
        guard let path = Bundle.main.path(forResource: "AppSandbox", ofType: "plist"), let keys = NSDictionary(contentsOfFile: path),
            let token = keys["TriposoKey"] as? String, let accountID = keys["TriposoAccount"] as? String else {
                self.token = ""; self.accountID = ""; return
        }
        self.token = token
        self.accountID = accountID
    }
    
    func attractionsInCity(title: String, handler: @escaping (Result<Attraction, Error>) -> Void) {
        guard let url = URL(string: "\(endpoint)poi.json") else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "location_id", value: title),
            URLQueryItem(name: "account", value: accountID),
            URLQueryItem(name: "token", value: token)
        ]
        guard let requestURL = components?.url else { return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            do {
                let attractions = try! JSONDecoder().decode(AttractionResults.self, from: data!)
                for i in attractions.all {
                    print(i)
                }
            } catch let error as NSError {
                handler(.failure(error))
            }
            
        }.resume()
        
    }
}
