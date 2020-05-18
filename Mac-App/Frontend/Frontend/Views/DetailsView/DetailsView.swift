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
        switch projectDetailsState.data {
        case .initial:
            return AnyView(
                LoadingView(
                    title: "Finding relevant stats...",
                    isloading: true
                )
            )
        case let .success(viewData: viewData):
            return AnyView(
                VStack {
                    Text("Heaviest dependency - \(viewData.heaviestDependency)")
                        .underline()
                        .foregroundColor(.red)
                        .font(.system(.headline))
                    Text("Total dependencies found: \(viewData.totalDependenciesFound)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(.body))
                    Text("Files scanned: \(viewData.paths.count)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(.body))
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        case let .failure(errorMessage):
            return
                AnyView(
                    Text("Something went wrong! - \(errorMessage)")
                )
        }
    }
}
