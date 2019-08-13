//
//  CountryDetailsPresenter.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/13/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

protocol CountryDetailsPresenting {
    var country: Country { get }
    var view: CountryDetailsView? { get set }
    var attractions: [Attraction] { get }
}

class CountryDetailsPresenter: CountryDetailsPresenting {
    weak var view: CountryDetailsView?
    let country: Country
    var attractions: [Attraction] = []
    
    init(country: Country) {
        self.country = country
        loadAttractions()
    }
    
    private func loadAttractions() {
        AttractionService.shared.attractionsInCity(title: country.capital) {[weak self] (result) in
            switch result {
            case .success(let attractions):
                print(attractions.count)
                self?.attractions = attractions
                DispatchQueue.main.async {
                    self?.view?.showAttractions()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
