//
//  FlickrCollectionViewCell.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit
import Kingfisher

class FlickrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    var url: URL?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(url: URL?) {
        self.imageView.kf.setImage(with: url)
    }
    
}
