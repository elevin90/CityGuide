//
//  RegionDetailsViewController.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/11/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit

class RegionDetailsViewController: UIViewController {

    private let region: Region
    
    @IBOutlet weak var tableView: UITableView!
    
    init(with region: Region) {
        self.region = region
        super.init(nibName: "RegionDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let nib = UINib(nibName: CountryTableViewCell.nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: CountryTableViewCell.nibName)
        tableView.register(RegionHeaderView.self, forHeaderFooterViewReuseIdentifier: RegionHeaderView.nibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.reloadData()
    }
}

extension RegionDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return region.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.nibName, for: indexPath) as? CountryTableViewCell
        let country = region.countries[indexPath.row]
        countryCell?.prepare(with: country.title, imagePath: country.flagPath)
        return countryCell ?? UITableViewCell()
    }
}

extension RegionDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RegionHeaderView.create()
        header?.prepare(with: region.title, image: UIImage(named: region.imageTitle))
        return header
    }
}
