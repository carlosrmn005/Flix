//
//  Movie.swift
//  Flix
//
//  Created by Junior on 11/20/18.
//  Copyright © 2018 Carlos Roman. All rights reserved.
//

import Foundation

class Movie
{
    var title: String
    var posterUrl: URL?
    var release_date: String
    var overview: String
    var backdropURL: URL?
    var posterURL: URL?
    
    init(dictionary: [String: Any])
    {
        let baseURLString = "https://image.tmdb.org/t/p/original"
        
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
        
        release_date = dictionary["release_date"] as? String ?? "No date"
        overview = dictionary["overview"] as? String ?? "No Description"
        let backdropPath = dictionary["backdrop_path"] as? String
        backdropURL = URL(string: baseURLString + backdropPath!)
        let posterPath = dictionary["poster_path"] as? String
        posterURL = URL(string: baseURLString + posterPath!)
    }
}
