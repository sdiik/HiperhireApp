//
//  PlaylistViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

class PlaylistViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalSongsLabel: UILabel!
    @IBOutlet weak var playlistTableView: UITableView! {
        didSet {
            playlistTableView.delegate = self
            playlistTableView.dataSource = self
        }
    }

    var namePlaylist: String?
    var playlist: PlaylistData?
    var songs: [SongData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupSongs()
        setupNavigation()
        setupTableView()
    }
    
    private func setupTitle() {
        titleLabel.text = namePlaylist
    }
    
    private func setupSongs() {
        if let alreadyNamePlaylist = namePlaylist, !alreadyNamePlaylist.isEmpty {
            guard let playlist = CoreDataLibrary.fetchPlaylist(byName: alreadyNamePlaylist) else { return }
            self.playlist = playlist
            songs = CoreDataLibrary.fetchSongs(from: playlist)
            totalSongsLabel.text = "\(songs.count) Songs"
        }
    }

    private func setupNavigation() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addSong))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "PlaylistTableViewCell", bundle: nil)
        playlistTableView.register(nib, forCellReuseIdentifier: "PlaylistTableViewCell")
    }

    @objc func addSong() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.playlistData = playlist
        self.navigationController?.present(searchVC, animated: true)
    }
}

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell") as? PlaylistTableViewCell
        else { return UITableViewCell() }
        cell.setupView(with: songs[indexPath.row])
        return cell
    }
}

extension PlaylistViewController: SearchViewModelDelegate {
    func didUpdateSearchResults() {
        setupSongs()
        playlistTableView.reloadData()
    }
}
