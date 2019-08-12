//
//  CountryTableViewCell.swift
//  CityGuide
//
//  Created by Evgeniy Levin on 8/12/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import UIKit
import WebKit

class CountryTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var webView: WKWebView!
   // @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let cache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }
    
    func prepare(with title: String, imagePath: String) {
        titleLabel.text = title
        if let url = URL(string: imagePath) {
        }
    }
}



//extension CountryTableViewCell {
//    private func manageImage(with url: URL)  {
//        flagImageView.image = nil
//        if let image = cache.object(forKey: url.absoluteString as NSString) {
//            DispatchQueue.main.async { [weak self] in
//                self?.flagImageView.image = image
//                return
//            }
//        } else {
//            URLSession.shared.dataTask(with: url) { (data, _, error) in
//                if error != nil { return }
//                if let _data = data { //let image = UIImage(data: _data) {
//                    let data2 = _data.pngData()
//                    DispatchQueue.main.async { [weak self] in
//                        print(url)
//                        //self?.flagImageView.image = image
//                      //  self?.cache.setObject(image, forKey: url.absoluteString as NSString)
//                    }
//                }
//            }.resume()
//        }
//    }
//}
