//
//  LibraryViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

class LibraryViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var libraryTableView: UITableView! {
        didSet {
            libraryTableView.delegate = self
            libraryTableView.dataSource = self
        }
    }
    @IBOutlet weak var libraryCollectionView: UICollectionView! {
        didSet {
            libraryCollectionView.delegate = self
            libraryCollectionView.dataSource = self
        }
    }

    var hideCollectionView: Bool = true {
        didSet {
            libraryCollectionView.isHidden = hideCollectionView
            libraryTableView.isHidden = !hideCollectionView
        }
    }

    var backgroundOverlay: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.isTabBarHidden = false
        refreshData()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        libraryTableView.register(nib, forCellReuseIdentifier: "ListTableViewCell")
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        libraryCollectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
    private func setupView() {
        switchButton.addTarget(self, action: #selector (switchButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
    }
    
    @objc func switchButtonTapped() {
        hideCollectionView.toggle()
        switchButton.setImage(UIImage(named: hideCollectionView ? "Switch" : "List"), for: .normal)
    }
    
    private func toPlaylist(with name: String) {
        let playlistVC = PlaylistViewController()
        playlistVC.namePlaylist = name
        self.navigationController?.pushViewController(playlistVC, animated: true)
    }
    
    private func refreshData() {
        libraryTableView.reloadData()
        libraryCollectionView.reloadData()
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataLibrary.fetchPlaylist().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell
        else { return UITableViewCell() }
        cell.setupData(with: CoreDataLibrary.fetchPlaylist()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlist = CoreDataLibrary.fetchPlaylist()[indexPath.row]
        toPlaylist(with: playlist.name ?? "")
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataLibrary.fetchPlaylist().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setupData(with: CoreDataLibrary.fetchPlaylist()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width-16)/2
        return CGSize(width: width, height: width+50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = CoreDataLibrary.fetchPlaylist()[indexPath.row]
        toPlaylist(with: playlist.name ?? "")
    }
}

extension LibraryViewController: BottomSheetDelegate {
    @objc func showBottomSheet() {
        backgroundOverlay = UIView(frame: view.bounds)
        backgroundOverlay?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundOverlay?.alpha = 0
        view.addSubview(backgroundOverlay!)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundOverlay?.alpha = 1
        }
        
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = self
        bottomSheetVC.delegate = self
        present(bottomSheetVC, animated: true)
    }
    
    func bottomSheetDidDismiss() {
        hideBottomSheet()
        let addPlaylistVC = AddPlaylistViewController()
        addPlaylistVC.delegate = self
        self.navigationController?.present(addPlaylistVC, animated: true)
    }
    
    func hideBottomSheet() {
        backgroundOverlay?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundOverlay?.alpha = 0
        }) { _ in
            self.backgroundOverlay?.removeFromSuperview()
        }
    }
}

extension LibraryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension LibraryViewController: AddPlaylistDelegate {
    func dismissAddPlaylistViewController(with playlist: String) {
        refreshData()
        toPlaylist(with: playlist)
    }
}
