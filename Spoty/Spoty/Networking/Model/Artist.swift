//
//  Artist.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

struct Artist: Decodable {

    let id: String?
    let name: String?
    let popularity: Int?
    let images: [Image]?
    let followers: Followers?
    let genres: [String]?
}

struct Followers: Decodable {
    let total: Int?
}
