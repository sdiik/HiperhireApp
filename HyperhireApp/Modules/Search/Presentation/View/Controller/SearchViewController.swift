//
//  SearchViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func didUpdateSearchResults()
}

class SearchViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var playlistSearchBar: UISearchBar! {
        didSet {
            playlistSearchBar.delegate = self
        }
    }
    @IBOutlet weak var resultTableView: UITableView! {
        didSet {
            resultTableView.delegate = self
            resultTableView.dataSource = self
        }
    }
    
    var delegate: SearchViewModelDelegate?
    var searchViewModel = SearchViewModel()
    var playlistData: PlaylistData?
    var keyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistSearchBar.placeholder = "Search"
        playlistSearchBar.becomeFirstResponder()
        setupTableView()
        searchViewModel.delegate = self
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchViewModel.searchResults.isEmpty ? "" : "Recent searches"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        else { return UITableViewCell() }
        cell.setupView(with: searchViewModel.searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = searchViewModel.searchResults[indexPath.row]
        if let alreadyPlaylistData = playlistData {
            CoreDataLibrary.addTrack(to: alreadyPlaylistData, track: searchResult)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.callSearch(keyword: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didUpdateSearchResults()
        }
    }
}

extension SearchViewController: SearchViewDelegate {
    func isLoading(status: Bool) {
        if status {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func searchSuccess() {
        onMainThreadAsync { [weak self] in
            self?.resultTableView.reloadData()
        }
    }
    
    func searchFailed(with message: String) {
        Alert.showMessage(with: message, controller: self)
    }
}
