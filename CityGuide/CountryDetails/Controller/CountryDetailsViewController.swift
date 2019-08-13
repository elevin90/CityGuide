//
//  CountryDetailsViewController.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/13/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit

protocol CountryDetailsView: AnyObject {
    func showAttractions()
    func showCityImages(from imageLinks: [CityImage])
}

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: CountryDetailsPresenting
    
    init(presenter: CountryDetailsPresenting) {
        self.presenter = presenter
        super.init(nibName: "CountryDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: AttractionTableViewCell.nibName, bundle: nil)
        let headerNib = UINib(nibName: AttractionTableHeaderView.nibName, bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: AttractionTableViewCell.nibName)
        tableView.register(CityImagesTableHeaderView.self, forHeaderFooterViewReuseIdentifier: CityImagesTableHeaderView.nibName)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: AttractionTableHeaderView.nibName)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight =  10
        navigationItem.title = presenter.country.capital
    }
}

extension CountryDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:  return 1
        case 2:  return presenter.attractions.count
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 2 else {
            return UITableViewCell()
        }
        let attraction = presenter.attractions[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AttractionTableViewCell.nibName,
                                                       for: indexPath) as? AttractionTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.prepare(title: attraction.title, rate: String(format: "avg: %.2f", attraction.raiting))
        return cell
    }
}

extension CountryDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = CityImagesTableHeaderView.create()
            header?.prepare(with:  presenter.cityImages)
            return header
        case 1:
            let header = AttractionTableHeaderView.create()
            header?.prepare(with:  "Weather for taday")
            return header
        case 2:
            let header = AttractionTableHeaderView.create()
            header?.prepare(with:  "Where to go?")
            return header
        default:
            return nil
        }
    }
}

extension CountryDetailsViewController: CountryDetailsView {
    func showCityImages(from imageLinks: [CityImage]) {
        if let header = tableView.headerView(forSection: 0) as? CityImagesTableHeaderView {
            header.prepare(with: imageLinks)
        }
    }
    
    func showAttractions() {
        tableView.reloadSections(IndexSet(integer: 2), with: .fade)
        activityIndicator.stopAnimating()
    }
}
