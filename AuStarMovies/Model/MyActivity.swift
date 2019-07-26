//
//  MyActivity.swift
//  AuStarMovies
//
//  Created by rose on 25/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import Foundation
import RealmSwift

class MyActivity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var genre: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var id: Int = 1
    
    
    convenience init( name: String, genre: String, date: String, id: Int) {
        self.init()
        self.name = name
        self.genre = genre
        self.date = date
        self.id = id
    }
    
    
    
}

extension Date {
    func dateToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: self)
        return "\(currentDate)"
    }
    
    
}
