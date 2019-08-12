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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.reloadData()
    }
}

extension RegionDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return region.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text  = region.countries[indexPath.row].title
        return cell
    }
}
