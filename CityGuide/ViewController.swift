//
//  ViewController.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let services = AttractionService.shared
        services.attractionsInCity(title: "London") { (result) in
            switch result {
            case .success(let responnse):
                print(responnse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

