//
//  SearchDataModel.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

struct SearchDataModel: Codable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Codable {
    let wrapperType: String?
    let artistId: Int?
    let collectionId: Int?
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright: String?
    let country: String?
    let currency: String?
    let releaseDate: String?
    let primaryGenreName: String?
    let previewUrl: String?
    let description: String?
}
