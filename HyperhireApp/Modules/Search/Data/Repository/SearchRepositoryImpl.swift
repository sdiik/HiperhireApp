//
//  SearchRepositoryImpl.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

class SearchRepositoryImpl: SearchRepository {
    let networkRepository: NetworkRepository
    let searchApiFactory: SearchApiFactory
    
    init(networkRepository: NetworkRepository = NetworkRepositoryImpl(),
         searchApiFactory: SearchApiFactory = SearchApiFactoryImpl()) {
        self.networkRepository = networkRepository
        self.searchApiFactory = searchApiFactory
    }
    
    func searchResult(pageNumber: Int?, pageSize: Int?, keyword: String?, result: @escaping SearchResult) {
        guard let url = searchApiFactory.createSearchUrl(pageNumber: pageNumber, pageSize: pageSize, keyword: keyword).url else {
            result(.failure(.loading))
            return
        }

        networkRepository.fetchRequest(url) { networkResult in
            switch networkResult {
            case .success(let response):
                let (urlResponse, data) = response
                guard urlResponse.statusCode.isOk else {
                    result(.failure(.loading))
                    return
                }
                self.parse(data: data, result: result)
            case .failure:
                result(.failure(.loading))
            }
        }
    }
    
    private func parse(data: Data, result: @escaping SearchResult) {
        do {
            let resultDecode = try JSONDecoder().decode(SearchDataModel.self, from: data)
            result(.success(resultDecode))
        } catch {
            result(.failure(.parsing))
        }
    }
}
