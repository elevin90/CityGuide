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
    var weather: WeatherForecast? { get }
    var view: CountryDetailsView? { get set }
    var attractions: [Attraction] { get }
    var cityImages: [CityImage] { get }
}

class CountryDetailsPresenter: CountryDetailsPresenting {

    weak var view: CountryDetailsView?
    let country: Country
    var weather: WeatherForecast?
    var attractions: [Attraction] = []
    var cityImages: [CityImage] = []
    
    init(country: Country) {
        self.country = country
        loadAttractions()
        loadImages()
        loadWeatherForecast()
    }
    
    private func loadImages() {
        CityImagesService.shared.loadImages(for: country.capital) {[weak self] (result) in
            switch result {
            case .success(let links):
                DispatchQueue.main.async {
                    self?.cityImages = links
                    self?.view?.showCityImages(from: links)
                }
            case .failure(let error):
                print(error)
            }
        }
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
    
    private func loadWeatherForecast() {
        WeatherService().weather(for: country.capital, handler: {[weak self] (result) in
            switch result {
            case .success(let forecast):
                self?.weather = forecast
                DispatchQueue.main.async {
                    self?.view?.showWeather(forecast: forecast)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
