//
//  DetailsView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DetailsView: View {
    @ObservedObject private var projectDetailsState: Observable<ProjectDetails.Status>

    public init(projectDetailsState: Observable<ProjectDetails.Status>) {
        self.projectDetailsState = projectDetailsState
    }

    public var body: some View {
        switch projectDetailsState.input {
        case .initial:
            return AnyView(
                LoadingView(
                    title: "Finding relevant stats...",
                    isloading: true
                )
            )
        case let .success(state: viewData):
            return AnyView(
                VStack {
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    Text("Heaviest dependency: ")
                        .foregroundColor(.yellow)
                        .font(.system(.headline))
                    Text(viewData.heaviestDependency)
                        .underline()
                        .font(.system(.subheadline))
                        .foregroundColor(.red)
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    Text("Total dependencies found: \(viewData.totalDependenciesFound)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(.body))
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    Text("Files scanned: \(viewData.paths.count)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(.body))
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                }
                .padding(EdgeInsets(top: 45, leading: 4, bottom: 45, trailing: 4))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        case let .failure(errorMessage):
            return
                AnyView(
                    Text("Something went wrong! - \(errorMessage)")
                )
        }
    }
}
