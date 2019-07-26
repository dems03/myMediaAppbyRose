//
//  Movie.swift
//  AuStarMovies
//
//  Created by rose on 24/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import Foundation
import UIKit


enum MovieError: Error {
    case noDataAvailable
    case cantProcessData
}

class Movie {
    
    var _movieName: String!
    var _movieGenre: String!
    var _moviePrice: Double!
    var _movieImage: String!
    var _longDescription: String!
    var _previewUrl: String!

    var movies: [Movie] = []
    
    
    var movieName: String {
        if _movieName == nil {
            _movieName = ""
        }
        return _movieName
    }
    
    var movieGenre: String {
        if _movieGenre == nil {
            _movieGenre = ""
        }
        return _movieGenre
    }
    
    var moviePrice: Double {
        if _moviePrice == nil {
            _moviePrice = 0.00
        }
        return _moviePrice
    }
    
    var longDescription: String {
        if _longDescription == nil {
            _longDescription = ""
        }
        return _longDescription
    }
    
    let resourceURL: URL
    
    
    init() {
        
        let resourceString = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp"
        
        guard let resourceUrl = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceUrl
    }
    
    
    // MARK: - Download from iTunes Search API
    
    
    func downloadMovies(completion: @escaping(Result<[MovieInfo], MovieError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {
            data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: jsonData)
                let movieInfo = movieResponse.results
                self.movies.removeAll()
                
                for obj in movieInfo {
                    let myMovie = Movie()
                    
                    if obj.trackName != nil {
                        
                        myMovie._movieName = obj.trackName
                        myMovie._movieGenre = obj.primaryGenreName
                        myMovie._movieImage = obj.artworkUrl60
                        //for test
                        //myMovie._movieImage = "\(obj.artworkUrl60)ppp"
                        
                        myMovie._moviePrice = obj.trackPrice
                        myMovie._longDescription = obj.longDescription
                        
                        self.movies.append(myMovie)

                    }

                }
                
                
                
                completion(.success(movieInfo))
                
                
            } catch {
                
                completion(.failure(.cantProcessData))
            }
        }
        dataTask.resume()
    }
    
    
}




