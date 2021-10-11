//
//  ArtistDetailViewController.swift
//  Spoty
//
//  Created by Bruno Fontes on 4/10/21.
//

import UIKit
import SVProgressHUD

class ArtistDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .greenSpoty
            nameLabel.font = .boldSystemFont(ofSize: 42)
            nameLabel.text = viewModel.artist.name
        }
    }
    @IBOutlet weak var popularity: UILabel! {
        didSet{
            popularity.textColor = .white
            popularity.font = .boldSystemFont(ofSize: 12)
            popularity.text = "Popularity: \(viewModel.artist.popularity ?? 0)%"
        }
    }
    @IBOutlet weak var followers: UILabel!{
        didSet{
            followers.textColor = .greenSpoty
            followers.font = .boldSystemFont(ofSize: 12)
            followers.text = "\(viewModel.artist.followers?.total ?? 0 ) Followers"
        }
    }

    @IBOutlet weak var genresLabel: UILabel!{
        didSet{

            guard let genres = viewModel.artist.genres else { return }
            genresLabel.text = getGenres(genres: genres)
            genresLabel.textColor = .white
            genresLabel.font = .boldSystemFont(ofSize: 12)
        }
    }

    @IBOutlet weak var songsLabel: UILabel!{
        didSet{
            songsLabel.textColor = .white
            songsLabel.backgroundColor = .greenSpoty
            songsLabel.text = "Tracks"
            songsLabel.font = .boldSystemFont(ofSize: 21)
        }
    }

    @IBOutlet weak var tableview: UITableView!{
        didSet {
            tableview.dataSource = self
            tableview.register(UINib(nibName: "ArtistDetailTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "ArtistDetailTableViewCell")
        }
    }

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
            closeButton.tintColor = .greenSpoty
        }
    }
    @IBOutlet weak var labelsStackView: UIStackView!{
        didSet{
            labelsStackView.backgroundColor = .blackSpoty
            labelsStackView.layer.opacity = 0.8
        }
    }

    // MARK: - Properties
    let viewModel: ArtistDetailsViewModel
    var albums: [Album] = []

    // MARK: - Life cycle

    required init(viewModel: ArtistDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ArtistDetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTracks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        view.backgroundColor = .blackSpoty
        tableview.backgroundColor = .greenSpoty
        setupImage()
    }

    private func setupImage(){
        guard let images =  viewModel.artist.images else { return }
        if images.count > 0 {
            artistImage.load(url: URL(string: images[0].url)!)
        } else {
            artistImage.load(url: URL(string: Service.noImageAvailable)!)
        }
    }

    private func getGenres(genres: [String]) -> String {
        let length = genres.count - 1
        if length < 0 { return ""}
        var genreText = "Genres: "
        for i in 1...length {
            if !(i == length){
                genreText += genres[i] + ", "
            } else {
                genreText += genres[i] + "."
            }
        }

        return genreText
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Service
extension ArtistDetailViewController {
    func getTracks() {
        SVProgressHUD.show()
        viewModel.getTracks {
            SVProgressHUD.dismiss()
            self.tableview.reloadData()
        } failure: { error in
            SVProgressHUD.dismiss()
            print(error)
        }
    }
}
// MARK: - TableView DataSource
extension ArtistDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.traks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistDetailTableViewCell",
                                                       for: indexPath)
                as? ArtistDetailTableViewCell else { return ArtistDetailTableViewCell() }

        let track = self.viewModel.traks[indexPath.row]
        cell.set(track: track)
        return cell
    }
}

