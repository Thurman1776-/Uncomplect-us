//
//  DetailsView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DetailsView: View {
    @ObservedObject private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(projectDetailsStatus: Observable<ProjectDetails.Status>) {
        self.projectDetailsStatus = projectDetailsStatus
    }

    public var body: some View {
        switch projectDetailsStatus.input {
        case .initial:
            return AnyView(
                LoadingView(
                    title: "Finding relevant stats...",
                    titleColor: .gray,
                    isloading: true
                ).frame(width: 200, height: 250)
            )
        case let .success(state: state):
            return AnyView(
                VStack {
                    Text("Heaviest dependency: ")
                        .foregroundColor(.lightBlue)
                        .font(.system(.headline))
                    Text(state.heaviestDependency)
                        .underline()
                        .font(.system(.subheadline))
                        .foregroundColor(.white)
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    Text("Total dependencies found: \(state.totalDependenciesFound)")
                        .bold()
                        .foregroundColor(.lightBlue)
                        .font(.system(.body))
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    Text("Files scanned: \(state.paths.count)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(.body))
                    Spacer().frame(minHeight: 16, maxHeight: 36)
                    PlainList(
                        titles: state.paths.map { String($0.absoluteString) },
                        itemsColor: .yellow
                    )
                }
                .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        case let .failure(errorMessage):
            return
                AnyView(
                    Text(errorMessage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
        }
    }
}
