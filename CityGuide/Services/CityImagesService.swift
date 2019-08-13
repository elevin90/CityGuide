//
//  CityImagesService.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/13/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

final class CityImagesService {
    private let endpoint = "https://api.unsplash.com/"
    private let accountID: String
    
    static let shared = CityImagesService()
    
    private init() {
        guard let path = Bundle.main.path(forResource: "AppSandbox", ofType: "plist"), let keys = NSDictionary(contentsOfFile: path), let accountID = keys["Unsplash"] as? String else {
            self.accountID = ""; return
        }
        self.accountID = accountID
    }
    
    public func loadImages(for city: String, handler: @escaping(Result<[Data], Error>) -> Void) {
        
    }
}
