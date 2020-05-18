//
//  ObservableData.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

// MARK: - View Data building blocks

/// `ViewInput` represents a template for observable objects that will emit updates to views via
/// a `@Published` property
/// The publisher is part of the generic class as protocols cannot have property wrappers ☹️
public protocol ViewInput {
    associatedtype Input: Equatable

    init(_ input: Input)
    func update(to newInput: Input)
}

open class Observable<T: Equatable>: ViewInput, ObservableObject {
    public typealias Input = T

    @Published private(set) var input: T

    public required init(_ input: T) {
        self.input = input
    }

    /// This triggers an UI update  for any view defining this class as a `@ObservedObject`

    public func update(to newInput: T) {
        DispatchQueue.main.async {
            self.input = newInput
        }
    }
}
