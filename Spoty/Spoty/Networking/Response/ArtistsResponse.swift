//
//  ArtistsResponse.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

struct ArtistResponse: Decodable {
    let artists: ArtistsItems
}

struct ArtistsItems: Decodable {
    let items: [Artist]
}
