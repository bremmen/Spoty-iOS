//
//  SpotyServiceError.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation
struct SpotyServiceError: Codable {
    let message: String
    let errors: [String: [String]]
}
