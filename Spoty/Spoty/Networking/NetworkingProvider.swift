//
//  NetworkingProvider.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation
import Alamofire

class NetworkingProvider {

    static let share = NetworkingProvider()

    func getToken(params: TokenForm, success: @escaping () -> (), failure: @escaping (_ error: Error?) -> () ) {
        AF.request(URL.init(string: Service.Endpoint.auth)!, method: .post, parameters: params).responseDecodable (of: TokenResponse.self)
        { (response) in
            switch response.result {

            case .success(_):
                    SessionManager.shared.token = response.value?.token
                    success()
            case .failure(let error):
                print(error)
                failure(response.error)
            }
        }
    }

    func getArtists(artist: String, success: @escaping (_ artists: ArtistResponse) -> (), failure: @escaping (_ error: Error?) -> () ) {
        let artistToSend:String = artist.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(Service.Endpoint.search)?q=\(artistToSend)&type=artist"
        guard let url: URL = URL(string: urlString),
              let token = SessionManager.shared.token else { return }
        AF.request(url, method: .get,
                   headers: ["Authorization": "Bearer \(token)"]).responseDecodable (of: ArtistResponse.self)
        { (response) in
            switch response.result {

            case .success(_):
                guard let artists =  response.value else { return }
                success(artists)
            case .failure(let error):
                print(error)
                failure(response.error)
            }
        }
    }

    func getArtist(artistId: String, success: @escaping (_ artist: Artist) -> (), failure: @escaping (_ error: Error?) -> () ) {
        let urlString = Service.Endpoint.getArtist + artistId
        guard let url: URL = URL(string: urlString),
              let token = SessionManager.shared.token else { return }
        AF.request(url, method: .get,
                   headers: ["Authorization": "Bearer \(token)"]).responseDecodable (of: Artist.self)
        { (response) in
            switch response.result {
            case .success(_):
                guard let artist =  response.value else { return }
                success(artist)
            case .failure(let error):
                print(error)
                failure(response.error)
            }
        }
    }

    func getTraks(artistId: String, success: @escaping (_ tracks: [Track]) -> (), failure: @escaping (_ error: Error?) -> () ) {
        let url = Service.Endpoint.getArtist + artistId + "/top-tracks?market=ES"
        guard let token = SessionManager.shared.token else { return }
        AF.request(URL.init(string: url)!, method: .get,
                   headers: ["Authorization": "Bearer \(token)"]).responseDecodable (of: TrackResponse.self)
        { (response) in
            switch response.result {
            case .success(_):
                guard let tracks =  response.value?.tracks else { return }
                success(tracks)
            case .failure(let error):
                print(error)
                failure(response.error)
            }
        }
    }


}
