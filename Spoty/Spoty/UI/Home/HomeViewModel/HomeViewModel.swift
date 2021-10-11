//
//  HomeViewModel.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

class HomeViewModel {

    var artists: [Artist] = []

    func getToken(success: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
        let param = TokenForm()
        NetworkingProvider.share.getToken(params: param) {
            success()
        } failure: { error in
            failure(error)
        }
    }

    func getArtists(artist: String, success: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
        NetworkingProvider.share.getArtists(artist: artist) { artists in
            self.artists = artists.artists.items.sorted(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
            success()
        } failure: { error in
            failure(error)
        }
    }

    func getArtist(artistId: String, success: @escaping (_ artist: Artist) -> (), failure: @escaping (_ error: Error?) -> ()) {
        NetworkingProvider.share.getArtist(artistId: artistId) { artist in
            success(artist)
        } failure: { error in
            failure(error)
        }
    }
}
