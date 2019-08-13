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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(CityImagesTableHeaderView.self, forHeaderFooterViewReuseIdentifier: CityImagesTableHeaderView.nibName)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight =  10
    }
}

extension CountryDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attraction = presenter.attractions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = attraction.title
        return cell
    }
}

extension CountryDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CityImagesTableHeaderView.create()
    }
}

extension CountryDetailsViewController: CountryDetailsView {
    func showAttractions() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}
