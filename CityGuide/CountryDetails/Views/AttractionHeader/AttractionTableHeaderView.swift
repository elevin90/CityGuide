//
//  AttractionTableHeaderView.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/13/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit

class AttractionTableHeaderView: UITableViewHeaderFooterView, NibLoadableView {

    @IBOutlet private weak var titleLabel: UILabel!
    
    static func create() -> AttractionTableHeaderView? {
        return Bundle.main.loadNibNamed(AttractionTableHeaderView.nibName, owner: nil, options: nil)?.first as? AttractionTableHeaderView
    }
    
    func prepare(with title: String) {
        titleLabel.text = title
    }
}
