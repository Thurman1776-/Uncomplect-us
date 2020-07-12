//
//  FrontendActions.swift
//  Frontend
//
//  Created by Daniel Garcia on 12.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

// MARK: - Public definitions

public protocol Action {}

public protocol Dispatching {
    static func dispatch(_ action: Action)
}

// MARK: - SwiftUI Environment plumbing

struct DumbDispatcher: Dispatching {
    static func dispatch(_: Action) {
        fatalError("Please override this from outside the Frontend module so actions can be listened to!")
    }
}

public struct DispatcherKey: EnvironmentKey {
    public static var defaultValue: Dispatching.Type = DumbDispatcher.self
}

public extension EnvironmentValues {
    var dispatcher: Dispatching.Type {
        get { self[DispatcherKey.self] }
        set { self[DispatcherKey.self] = newValue }
    }
}

