//
//  Track.swift
//  Spoty
//
//  Created by Bruno Fontes on 4/10/21.
//

import Foundation

struct Album: Decodable {
    let name: String
    let images: [Image]?
}
