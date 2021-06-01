//
//  Movie.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation

struct MoviesJSON: Decodable {
    let movies: [Movies]
}

struct Movies: Decodable {
    let title: String
    let year: Int?
    let cast: [String]
    let genres: [String]
    let rating: Int
}


extension Movies {
    static func fetchMovies() -> [Movies] {
        let movies =  Bundle.main.decode(MoviesJSON.self, from: "movies.json")
        let moviesCollection = movies.movies
        return moviesCollection
    }
}
