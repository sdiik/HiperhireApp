//
//  SearchUseCase.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

typealias SearchUseCaseCompletionHandler = (_ result: Result<SearchDataModel, SearchError>) -> Void

protocol SearchUseCase {
    func execute(pageNumber: Int?, pageSize: Int?, keyword: String?, completionHandler: @escaping SearchUseCaseCompletionHandler)
}
