//
//  MovieCVCell.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 29/02/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit

class MovieCVCell: UICollectionViewCell {

    //#MARK:Outlets
    @IBOutlet var viewBGM: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.viewBGM.frame = CGRect.init(x: 4, y: 4, width: self.contentView.frame.size.width - 8, height: self.contentView.frame.size.height - 8)

    }
    
    func configure(_ movie: MovieData) {
        
        imageView.kf.indicatorType = .activity
        
        imageView.kf.setImage(with: movie.posterURL)
        
        titleLabel.text = movie.title
                
    }
    
}
