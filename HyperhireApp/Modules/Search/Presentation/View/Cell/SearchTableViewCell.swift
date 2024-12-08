//
//  SearchTableViewCell.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    var track: Track?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchImageView.layer.cornerRadius = 25
        typeLabel.text = "Song"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(with data: Track) {
        track = data
        loadImageGame()
        setTitle()
        setSinger()
    }

    private func setTitle() {
        titleLabel.text = track?.trackName ?? ""
    }
    
    private func setSinger() {
        singerLabel.text = track?.artistName ?? ""
    }
    
    private func loadImageGame() {
        guard let alreadyImageURL = track?.artworkUrl60  else { return }
        searchImageView.loadImageUsingCache(withUrl: alreadyImageURL)
    }
}
