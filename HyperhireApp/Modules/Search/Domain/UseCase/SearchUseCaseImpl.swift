//
//  SearchUseCaseImpl.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

class SearchUseCaseImpl: SearchUseCase {
    let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository = SearchRepositoryImpl()) {
        self.searchRepository = searchRepository
    }
    
    func execute(pageNumber: Int?, pageSize: Int?, keyword: String?, completionHandler: @escaping SearchUseCaseCompletionHandler) {
        searchRepository.searchResult(pageNumber: pageNumber, pageSize: pageSize, keyword: keyword) { result in
            switch result {
            case .success(let result):
                completionHandler(.success(result))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
