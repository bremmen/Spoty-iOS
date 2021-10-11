//
//  Service.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

enum Service {
    static let baseUrl = "https://api.spotify.com/"
    static let clienteId = "2e787e71a66e4f2088b9470083795074"
    static let secretId = "676e7fa5532d414fba698a4391fe5f91"
    static let noImageAvailable = "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"

    enum Endpoint {
        static let auth = "https://accounts.spotify.com/api/token"
        static let search = Service.baseUrl + "v1/search"
        static let getArtist = Service.baseUrl + "v1/artists/"
    }
}
