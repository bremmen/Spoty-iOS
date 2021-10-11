//
//  ArtistDetailsBuilder.swift
//  Spoty
//
//  Created by Bruno Fontes on 4/10/21.
//

import Foundation
import UIKit

struct ArtistDetailsBuilder {
    static func Build(artist: Artist) -> ArtistDetailViewController {
        let viewModel: ArtistDetailsViewModel = ArtistDetailsViewModel(artist: artist)
        let controller: ArtistDetailViewController = ArtistDetailViewController(viewModel: viewModel)

        return controller
    }
}
