//
//  NetworkRepository.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

typealias FetchRequestResult = (_ result: Result<(HTTPURLResponse, Data), Error>) -> Void

protocol NetworkRepository {
    func fetchRequest(_ url: URL, result: @escaping FetchRequestResult)
}
