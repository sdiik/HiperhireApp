//
//  SearchViewModel.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

protocol SearchViewDelegate {
    func isLoading(status: Bool)
    func searchSuccess()
    func searchFailed(with message: String)
}

class SearchViewModel {
    private let searchUseCase: SearchUseCase
    var delegate: SearchViewDelegate?
    
    var keyword = ""
    var pageNumber = 1
    var pageSize = 10
    
    var searchResults = [Track]() {
        didSet {
            delegate?.searchSuccess()
        }
    }
    
    init(searchUseCase: SearchUseCase = SearchUseCaseImpl()) {
        self.searchUseCase = searchUseCase
    }
    
    func callSearch(keyword: String = "", isUpdate: Bool = false) {
        if !isUpdate { pageNumber = 1 }
        delegate?.isLoading(status: true)
        searchUseCase.execute(pageNumber: pageNumber, pageSize: pageSize, keyword: keyword) { [weak self] result in
            onMainThreadAsync { [weak self] in
                switch result {
                case .success(let data):
                    if self?.pageNumber == 1 {
                        self?.searchResults = data.results
                    } else {
                        self?.searchResults.append(contentsOf: data.results)
                    }
                    self?.pageNumber += 1
                case .failure(let error):
                    self?.delegate?.searchFailed(with: error.localizedDescription)
                }
                self?.delegate?.isLoading(status: false)
            }
        }
    }
}
