//
//  PlaylistTableViewCell.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 07/12/24.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    var songData: SongData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(with data: SongData?) {
        songData = data
        titleLabel.text = songData?.trackName ?? ""
        singerLabel.text = songData?.artistName ?? ""
        
        if let alreadyImage = songData?.artworkUrl60 {
            playlistImageView.loadImageUsingCache(withUrl: alreadyImage)
        }
    }
    
}
