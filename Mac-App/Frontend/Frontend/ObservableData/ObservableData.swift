//
//  ObservableData.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation
// This should not be imported in Frontend. Testing if this fixes CI problems
import Combine

// MARK: - View Data building blocks

/// `ViewInput` represents a template for observable objects that will emit updates to views via
/// a `@Published` property
/// The publisher is part of the generic class as protocols cannot have property wrappers ☹️
public protocol ViewInput {
    associatedtype Data: Equatable

    init(_ data: Data)
    func render(_ newData: Data)
}

open class ObservableData<T: Equatable>: ViewInput, ObservableObject {
    public typealias Data = T

    @Published private(set) var data: T

    public required init(_ data: T) {
        self.data = data
    }

    /// This triggers an UI update  for any view defining this class as a `@ObservedObject`

    public func render(_ newData: T) {
        DispatchQueue.main.async {
            self.data = newData
        }
    }
}
