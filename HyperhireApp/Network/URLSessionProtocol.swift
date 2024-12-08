//
//  URLSessionProtocol.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
