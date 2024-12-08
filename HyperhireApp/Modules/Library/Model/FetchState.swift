//
//  FetchState.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 06/12/24.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case noResults
    case error(String)
}
