//
//  CityImagesTableHeaderView.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/13/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit

class CityImagesTableHeaderView: UITableViewHeaderFooterView, NibLoadableView {

    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private var images: [UIImageView]!
    
    static func create() -> CityImagesTableHeaderView? {
        return Bundle.main.loadNibNamed(CityImagesTableHeaderView.nibName, owner: nil, options: nil)?.first as? CityImagesTableHeaderView
    }
    
    func prepare(with cityImages: [UIImage]) {
        for (index,image) in cityImages.enumerated() {
            images[index].image = image
        }
    }
}
