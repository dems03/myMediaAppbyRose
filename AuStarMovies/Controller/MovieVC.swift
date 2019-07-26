//
//  MovieVC.swift
//  AuStarMovies
//
//  Created by rose on 25/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import UIKit
import RealmSwift
class MovieVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lastVisit: UILabel!
    
    

    
    let movie = Movie()
    let date = Date()
    var detailsVC: DetailsVC?
    var activities: Results<MyActivity>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies()
        let realm = RealmService.shared.realm
        activities = realm.objects(MyActivity.self)
        
        self.tableView.rowHeight = 99.0
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateActivity(_:)), name: NSNotification.Name(rawValue: "update"), object: nil)

    }
    
    
    
    
    func getMovies() {
        
        movie.downloadMovies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.checkLastActivity()
                    
                }
            }
        }
    }
    
    
    // MARK: TableView Setup
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movie.movies.count > 0 {
            return movie.movies.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            
            if movie.movies.count > 0 {
                
                let myMovie = movie.movies[indexPath.item]
                cell.configureCell(movieInfo: myMovie)
                
            }
            return cell
   
        }
        
        return MovieCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mySelectedMovie = movie.movies[indexPath.item]
        
        if let myActivities = activities, activities.count > 0 {
            
            for act in myActivities {
                if act.id == 1 {
                    
                    RealmService.shared.update(act, with: ["name": mySelectedMovie.movieName, "genre": mySelectedMovie._movieGenre, "date": date.dateToday()])
                    
                }
                
                
            }
        }
        
        
        detailsVC = DetailsVC()
        detailsVC?.imgString = mySelectedMovie._movieImage
        detailsVC?.MovieName = mySelectedMovie._movieName
        detailsVC?.MovieGenre = mySelectedMovie._movieGenre
        if let longD = mySelectedMovie._longDescription {
            detailsVC?.longDescription = longD
        }
        
        detailsVC?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        detailsVC?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(detailsVC!, animated: true,completion: nil)
    }
    
    


    
    // MARK: Data Persistence
    
    // Retrieve last date of visit before displaying the view
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if displayDate() != "" {
            lastVisit.text = "Last seen: \(displayDate())"
        } else {
            lastVisit.text = ""
        }
        
    }
    
    
    func displayDate() -> String {
        
        var myLastVisit = ""
        
        if let myActivities = activities, activities.count > 0 {
            
            let actArr = myActivities.filter{return ($0.id == 1)}
            
            for act in actArr {
                
                myLastVisit = act.date
                
                
            }
        }
        
        return myLastVisit
    }
    
    func checkLastActivity(){
        
        if let myActivities = activities, activities.count > 0 {
            
            let actArr = myActivities.filter{return ($0.id == 1)}
            
            for act in actArr {
  
                    if (act.name != "Home"){
                        openLastMovie(mname: act.name,mgenre: act.genre )
                        
                    } else {
                        RealmService.shared.update(act, with: ["date": date.dateToday()])
    
                    }

            }
        } else {
            RealmService.shared.create(MyActivity(name: "Home", genre: "na", date: date.dateToday(), id: 1))
        }
        
        
    }
    
    func openLastMovie(mname: String, mgenre: String) {
        
        let arr = movie.movies.filter{return ($0._movieName == mname && $0._movieGenre == mgenre)}
        print("\(arr.count) ")
        
        detailsVC = DetailsVC()
        
        detailsVC?.imgString = arr[0]._movieImage
        detailsVC?.MovieName = mname
        detailsVC?.MovieGenre = mgenre
        if let longD = arr[0]._longDescription {
            detailsVC?.longDescription = longD
        }

        detailsVC?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        detailsVC?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(detailsVC!, animated: true,completion: nil)
        
    }
    
    @objc func updateActivity(_ notification: NSNotification){

        if let myActivities = activities, activities.count > 0 {
            
            let actArr = myActivities.filter{return ($0.id == 1)}
            
            for act in actArr {

                RealmService.shared.update(act, with: ["name": "Home", "genre":"na", "date": date.dateToday()])
 
            }
        }
    }
    
    

}




