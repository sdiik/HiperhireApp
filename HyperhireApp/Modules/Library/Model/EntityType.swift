//
//  EntityType.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 06/12/24.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    func name() -> String {
        switch self {
            case .all:
                return "All"
            case .album:
                return "Albums"
            case .song:
                return "Songs"
            case .movie:
                return "Movies"
        }
    }
}
