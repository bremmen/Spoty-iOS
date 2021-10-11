//
//  ArtistDetailTableViewCell.swift
//  Spoty
//
//  Created by Bruno Fontes on 4/10/21.
//

import UIKit

class ArtistDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTrack: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .boldSystemFont(ofSize: 14)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(track: Track){
        nameLabel.text = track.name

        guard let images =  track.album.images else { return }
        if images.count > 0 {
            imageTrack.load(url: URL(string: images[0].url)!)
        } else {
            imageTrack.load(url: URL(string: Service.noImageAvailable)!)
        }
    }
}
