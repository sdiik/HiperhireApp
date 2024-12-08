//
//  SearchApiFactoryImpl.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

struct SearchApiFactoryImpl: SearchApiFactory {
    func createSearchUrl(pageNumber: Int?, pageSize: Int?, keyword: String?) -> URLComponents {
        var components = URLComponents()
        components.scheme = API_SCHEME
        components.host = API_HOST
        components.path = "/search"
        components.queryItems = []
        if let alreadyPageNumber = pageNumber {
            components.queryItems?.append(URLQueryItem(name: "page", value: "\(alreadyPageNumber)"))
        }
        if let alreadyPageSize = pageSize {
            components.queryItems?.append(URLQueryItem(name: "limit", value: "\(alreadyPageSize)"))
        }
        if let alreadyKeyword = keyword, !alreadyKeyword.isEmpty {
            components.queryItems?.append(URLQueryItem(name: "term", value: alreadyKeyword))
        }
        components.queryItems?.append(URLQueryItem(name: "media", value: "music"))
        return components
    }
}
