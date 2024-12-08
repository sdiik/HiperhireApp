//
//  ListTableViewCell.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var stackViewOne: UIStackView!
    @IBOutlet weak var stackViewTwo: UIStackView!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var totalSongsLabel: UILabel!
    
    var playlistData: PlaylistData?
    var songs = [SongData]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageOne.image = nil
        imageTwo.image = nil
        imageThree.image = nil
        imageFour.image = nil
        
        imageOne.isHidden = false
        imageTwo.isHidden = false
        imageThree.isHidden = false
        imageFour.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(with data: PlaylistData) {
        playlistData = data
        titleLabel.text = playlistData?.name
        typeLabel.text = "Playlist"
        setSongView()
        setImage()
    }
    
    private func setSongView() {
        if let alreadyPlaylist = playlistData {
            let totalSongs = CoreDataLibrary.fetchSongs(from: alreadyPlaylist).count
            totalSongsLabel.text = "\(totalSongs) Songs"
        } else {
            totalSongsLabel.text = "0 Songs"
        }
    }
    
    private func setImage() {
        guard let alreadyPlaylist = playlistData else { return }
        songs = CoreDataLibrary.fetchSongs(from: alreadyPlaylist)

        if songs.indices.contains(0),
           let songOne = songs[0].artworkUrl60 {
            imageOne.loadImageUsingCache(withUrl: songOne)
        } else {
            imageOne.isHidden = true
        }
        
        if songs.indices.contains(1),
           let songTwo = songs[1].artworkUrl60 {
            imageTwo.loadImageUsingCache(withUrl: songTwo)
        } else {
            imageTwo.isHidden = true
        }
        
        if songs.indices.contains(2),
           let songThree = songs[2].artworkUrl60 {
            imageThree.loadImageUsingCache(withUrl: songThree)
        } else {
            imageThree.isHidden = true
        }
        
        if songs.indices.contains(3),
           let songFour = songs[3].artworkUrl60 {
            imageFour.loadImageUsingCache(withUrl: songFour)
        } else {
            imageFour.isHidden = true
        }
        
        stackViewOne.isHidden = imageOne.isHidden && imageTwo.isHidden
        stackViewTwo.isHidden = imageThree.isHidden && imageFour.isHidden
        
    }
}
