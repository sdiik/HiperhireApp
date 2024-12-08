//
//  SearchApiFactory.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

protocol SearchApiFactory {
    func createSearchUrl(pageNumber: Int?, pageSize: Int?, keyword: String?) -> URLComponents
}
