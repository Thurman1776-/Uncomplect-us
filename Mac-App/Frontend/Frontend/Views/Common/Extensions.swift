//
//  Extensions.swift
//  Frontend
//
//  Created by Daniel Garcia on 14.06.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

// MARK: - Color

extension Color {
    static let lightGray = Color(.sRGB, red: 70 / 255, green: 70 / 255, blue: 70 / 255, opacity: 1.0)
    static let lightBlue = Color(.sRGB, red: 78 / 255, green: 176 / 255, blue: 204 / 255, opacity: 1.0)
    static let lightGreen = Color(.sRGB, red: 120 / 255, green: 194 / 255, blue: 179 / 255, opacity: 1.0)
}

// MARK: - String

extension String: Identifiable {
    public var id: Int { hashValue }
}

// MARK: - Debugging

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
