//
//  MovieDetailCVCell.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 01/03/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit

class MovieDetailCVCell: UICollectionViewCell {
    
    //#MARK:Outlets

    @IBOutlet var viewBGM: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var overviewtextview: UITextView!

    private let dateFormatter: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateStyle = .long
         formatter.timeStyle = .none
         
         return formatter
     }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewBGM.frame = CGRect.init(x: 8, y: 8, width: self.contentView.frame.size.width - 16, height: self.contentView.frame.size.height - 16)
        
    }
    
    func configure(_ movie: MovieData) {
           
           imageView.kf.indicatorType = .activity
           
           imageView.kf.setImage(with: movie.posterURL)
           
           dateLabel.text = dateFormatter.string(from: movie.releaseDate)

           titleLabel.text = movie.title
        
           overviewtextview.text = movie.overview
        
    }

}
