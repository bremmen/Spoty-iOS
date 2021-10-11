//
//  ArtistDetailViewModel.swift
//  Spoty
//
//  Created by Bruno Fontes on 4/10/21.
//

import Foundation

class ArtistDetailsViewModel {


    let artist: Artist
    var traks: [Track] = []

    init(artist: Artist){
        self.artist = artist
    }

    func getTracks(success: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
        guard let artistId = artist.id else { return }
        NetworkingProvider.share.getTraks(artistId: artistId) { tracks in
             self.traks = tracks
            success()
        } failure: { error in
            failure(error)
        }

    }
}
