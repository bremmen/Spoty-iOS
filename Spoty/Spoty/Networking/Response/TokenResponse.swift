//
//  TokenResponse.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

struct TokenResponse: Decodable {
    let token: String

    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}
