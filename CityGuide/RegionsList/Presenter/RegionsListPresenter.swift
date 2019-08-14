//
//  RegionsListPresenter.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/11/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation

protocol RegionsListPresenting: AnyObject {
    var view: RegionsListView? { set get }
    func loadCountries()
    func region(at index: Int) -> Region
    func country(at path: IndexPath) -> Country
    func regionsCount() -> Int
}

class  RegionsListPresenter {
    
    weak var view: RegionsListView?
    private var regions = [Region]()
}

extension RegionsListPresenter: RegionsListPresenting{
    func regionsCount() -> Int {
        return regions.count
    }

    func loadCountries() {
        CountriesService.loadAllCountriea {[weak self] (result) in
            guard let welf = self else { return }
            switch result {
            case .success(let countries):
                DispatchQueue.main.async {
                    welf.view?.showRegions(welf.sortCountries(countries: countries))
                }
            case .failure(let error):
                welf.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func region(at index: Int) -> Region {
        return regions[index]
        
    }
    
    func country(at path: IndexPath) -> Country {
        return regions[path.section].countries[path.row]
    }
    
    private func sortCountries(countries: [Country]) -> [Region] {
        let type = Region.RegionType.self
        let europeanCountries = countries.compactMap{$0}.filter{$0.region == type.Europe.rawValue}
        let africanCountries = countries.compactMap{$0}.filter{$0.region  ==  type.Africa.rawValue}
        let asianCountries = countries.compactMap{$0}.filter{$0.region == type.Asia.rawValue}
        regions = [Region(title: type.Europe.rawValue, countries: europeanCountries, imageTitle: type.Europe.rawValue),
                Region(title: type.Africa.rawValue, countries: africanCountries, imageTitle: type.Africa.rawValue),
                Region(title: type.Asia.rawValue, countries: asianCountries, imageTitle: type.Asia.rawValue)]
        return regions
    }
}
