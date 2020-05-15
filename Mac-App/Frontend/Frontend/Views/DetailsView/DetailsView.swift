//
//  DetailsView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DetailsView: View {
    @ObservedObject private var projectDetailsState: ObservableData<ProjectDetails.State>

    public init(projectDetailsState: ObservableData<ProjectDetails.State>) {
        self.projectDetailsState = projectDetailsState
    }

    public var body: some View {
        Text("Options will go here")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
