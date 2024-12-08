//
//  SearchRepository.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

typealias SearchResult = (_ result: Result<SearchDataModel, SearchError>) -> Void

protocol SearchRepository {
    func searchResult(pageNumber: Int?, pageSize: Int?, keyword: String?, result: @escaping SearchResult)
}
