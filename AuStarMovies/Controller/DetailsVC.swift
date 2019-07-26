//
//  DetailsVC.swift
//  AuStarMovies
//
//  Created by rose on 25/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    
    @IBOutlet weak var selMovieImage: UIImageView!
    @IBOutlet weak var selMovieName: UILabel!
    @IBOutlet weak var selMovieGenre: UILabel!
    @IBOutlet weak var selLongDesc: UITextView!
    
    
    var MovieName = ""
    var MovieGenre = ""
    var longDescription = "No other description provided."
    var imgString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newStr = imgString.replacingOccurrences(of: "60x60", with: "400x400")
        selMovieImage.kf.setImage(with: URL(string: newStr), placeholder:  UIImage(named: "placeH"))
        selMovieGenre.text = MovieGenre
        selMovieName.text = MovieName
        selLongDesc.text = longDescription
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        self.dismiss(animated: true, completion: nil)
        
    }


}
