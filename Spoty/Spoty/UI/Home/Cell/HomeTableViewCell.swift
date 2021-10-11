//
//  HomeTableViewCell.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .greenSpoty
            nameLabel.font = .boldSystemFont(ofSize: 20)
        }
    }
    @IBOutlet weak var popularityLabel: UILabel! {
        didSet{
            popularityLabel.text = "Popularity"
            popularityLabel.textColor = .white
        }
    }
    @IBOutlet weak var followersLabel: UILabel! {
        didSet {
            followersLabel.text = "Followers"
            followersLabel.textColor = .white
        }
    }
    @IBOutlet weak var popularity: UILabel! {
        didSet{
            popularity.textColor = .greenSpoty
        }
    }
    @IBOutlet weak var followers: UILabel!{
        didSet{
            followers.textColor = .greenSpoty
        }
    }
    @IBOutlet weak var ArtistImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(artist: Artist) {
        let popularityArtist: String = String(artist.popularity ?? 0)
        let followersArtist: String = String(artist.followers?.total ?? 0)

        nameLabel.text = artist.name
        popularity.text = popularityArtist
        followers.text = followersArtist
        
        guard let images =  artist.images else { return }
        if images.count > 0 {
            ArtistImage.load(url: URL(string: images[0].url)!)
        } else {
            ArtistImage.load(url: URL(string: Service.noImageAvailable)!)
        }
    }
}


