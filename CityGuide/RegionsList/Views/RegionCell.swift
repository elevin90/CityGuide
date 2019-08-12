//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Evgeniy on 19.08.2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

class RegionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private let cache =              NSCache<NSString, UIImage>()
    private var isPressed =  false
    var initialFrame:        CGRect? = nil
    var initialCornerRadius: CGFloat? = nil
    
    static let cellID = "RegionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override var isHighlighted: Bool {
        didSet { bounce(isHighlighted) }
    }
    
    var bounceCompletion: ((Bool)->())? = nil
    
    
    private func bounce(_ bounce: Bool) {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { self.transform = bounce ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity },
            completion: nil)
    }
    
    private func configureCell() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = contentView.layer.cornerRadius
    }
    
    class func create(owner: UIViewController) -> RegionCell {
        return Bundle.main.loadNibNamed(self.cellID, owner: owner, options: nil)?.first as! RegionCell
    }
    
    func fill(with region: Region) {
        nameLabel.text = region.title
        imageView.image = UIImage(named: region.imageTitle)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

extension RegionCell {
   private func manageImage(with url: URL)  {
        imageView.image = nil
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
                return
            }
        } else {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil { return }
            if let _data = data, let image = UIImage(data: _data) {
                DispatchQueue.main.async { [weak self] in
                    print(url)
                    self?.imageView.image = image
                    self?.cache.setObject(image, forKey: url.absoluteString as NSString)
                    }
                }
            }.resume()
        }
    }
}

//MARK: Expanded logic

extension RegionCell {
    func expand(in collectionView: UICollectionView) {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.initialFrame =  self?.frame
             self?.initialCornerRadius =  self?.contentView.layer.cornerRadius
             self?.contentView.layer.cornerRadius = 0
             self?.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        }) { (isFinished) in
             self.layoutIfNeeded()
        }
    }
    
    func collapse() {
        contentView.layer.cornerRadius = initialCornerRadius ?? contentView.layer.cornerRadius
        frame = initialFrame ?? frame
        initialFrame = nil
        initialCornerRadius = nil
        layoutIfNeeded()
    }
}


