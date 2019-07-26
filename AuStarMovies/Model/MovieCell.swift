//
//  MovieCell.swift
//  AuStarMovies
//
//  Created by rose on 24/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePrice: UILabel!
    @IBOutlet weak var movGenre: UILabel!
    
    
    func configureCell(movieInfo: Movie){
        
        guard let imgString = movieInfo._movieImage else { return}
        
        movieImg?.kf.setImage(with: URL(string: imgString), placeholder:  UIImage(named: "pHsmall"))

        movieName.text = movieInfo._movieName
        movGenre.text = movieInfo._movieGenre
        moviePrice.text = "$\(movieInfo._moviePrice ?? 0.00)"
        
        

    }
    
    
        
    
    
    

    
}
