//
//  HomeViewController.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "🎵 Spoty 🎶"
            titleLabel.textColor = .greenSpoty
            titleLabel.font = .boldSystemFont(ofSize: 24)
        }
    }
    @IBOutlet weak var textfield: UITextField! {
        didSet {
            textfield.attributedPlaceholder = NSAttributedString(string: "Search an artist...",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textfield.textColor = .white
            textfield.backgroundColor = .clear
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 2
            textfield.layer.cornerRadius = 9
            textfield.addTarget(self, action: #selector(self.searchArtists(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var tableview: UITableView!{
        didSet {
            tableview.dataSource = self
            tableview.delegate = self
            tableview.register(UINib(nibName: "HomeTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "HomeTableViewCell")
        }
    }
    @IBOutlet weak var emptyView: UIView! {
        didSet {
            emptyView.isHidden = false
        }
    }
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        setUI()
    }

    private func setUI() {
        view.backgroundColor = .blackSpoty
        tableview.isHidden = true
    }

    @objc private func searchArtists(_ textField: UITextField){
        guard let artist = textfield.text else { return }
        searchArtists(artist: artist)
    }
}
// MARK: - Service
extension HomeViewController {
    func getToken(){
        SVProgressHUD.show()
        viewModel.getToken {
            SVProgressHUD.dismiss()
            print("TOKEN: \(SessionManager.shared.token)")
        } failure: { error in
            SVProgressHUD.dismiss()
        }
    }
    func searchArtists(artist: String) {
        SVProgressHUD.show()
        viewModel.getArtists(artist: artist) {
            SVProgressHUD.dismiss()
            if(self.viewModel.artists.count > 0) {
                self.tableview.reloadData()
                self.tableview.isHidden = false
                self.emptyView.isHidden = true
            } else {
                self.tableview.isHidden = true
                self.emptyView.isHidden = false

            }

        } failure: { error in
            SVProgressHUD.dismiss()
        }
    }

    func getArtist(artistId: String) {
        SVProgressHUD.show()
        viewModel.getArtist(artistId: artistId) { artist in
            SVProgressHUD.dismiss()
            self.present(ArtistDetailsBuilder.Build(artist: artist), animated: true, completion: nil)
        } failure: { error in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
}
// MARK: - TableView DataSource, Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.artists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell",
                                                       for: indexPath)
                as? HomeTableViewCell else { return HomeTableViewCell() }

        let artist = viewModel.artists[indexPath.row]
        cell.set(artist: artist)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artistId = viewModel.artists[indexPath.row].id else { return }
        getArtist(artistId: artistId)
    }
}
