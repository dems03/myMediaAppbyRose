//
//  MoviesResponse.swift
//  AuStarMovies
//
//  Created by rose on 24/07/2019.
//  Copyright © 2019 rose. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    var results: [MovieInfo]
}

struct MovieInfo: Decodable {
    var trackName: String?
    var artworkUrl60: String
    var primaryGenreName: String
    var trackPrice: Double?
    var longDescription: String?
}
