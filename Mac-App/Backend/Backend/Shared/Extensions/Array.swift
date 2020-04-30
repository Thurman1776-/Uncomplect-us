//
//  Array.swift
//  Backend
//
//  Created by Emre Havan on 30.04.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
