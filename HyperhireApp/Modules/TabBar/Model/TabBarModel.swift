//
//  TabBarModel.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 06/12/24.
//

//

import Foundation

enum tabBarType: String {
    case home
    case search
    case library
    
    var tabTitle: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return "My Library"
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return ""
        }
    }
    
    var navigationIconName: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return "Library"
        }
    }
    
    
}


