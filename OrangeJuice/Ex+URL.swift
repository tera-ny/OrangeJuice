//
//  Ex+URL.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import Foundation

extension URL: Identifiable {
    public var id: String {
        absoluteString
    }
}
