//
//  IntExtension.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

typealias HTTPStatusCode = Int

extension HTTPStatusCode {
    var isOk: Bool {
        return self >= 200 && self < 300
    }
}
