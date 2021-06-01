//
//  Flickr.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation

struct Flickr: Decodable {
    let photos: Photos
}

struct Photos: Decodable {
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}


