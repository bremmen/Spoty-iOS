//
//  TokenForm.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

struct TokenForm: Codable {

    let grantType: String = "client_credentials"
    let clientId: String = Service.clienteId
    let clientSecret: String = Service.secretId

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}
