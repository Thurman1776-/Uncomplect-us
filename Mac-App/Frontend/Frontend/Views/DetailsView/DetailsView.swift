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

    @ViewBuilder public var body: some View {
        switch projectDetailsStatus.input {
        case .initial:
            LoadingView(
                title: "Finding relevant stats...",
                titleColor: .gray,
                isLoading: true
            ).frame(width: 200, height: 250)
        case let .success(state: state):
            VStack {
                VStack {
                    Text("Heaviest dependency: ")
                        .foregroundColor(.lightBlue)
                        .font(.system(.headline))
                    Text(state.heaviestDependency)
                        .underline()
                        .font(.system(.subheadline))
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 8, leading: 4, bottom: 16, trailing: 4))

                VStack {
                    Text("Total dependencies found: \(state.totalDependenciesFound)")
                        .bold()
                        .foregroundColor(.lightBlue)
                        .font(.system(.body))
                }
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 16, trailing: 4))

                Text("Files scanned: \(state.paths.count)")
                    .bold()
                    .foregroundColor(.lightGreen)
                    .font(.system(.body))
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 16, trailing: 4))

                PlainList(
                    titles: state.paths.map { String($0.absoluteString) },
                    itemsColor: .yellow
                )
            }
            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .failure(errorMessage):
            Text(errorMessage)
                .bold()
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom], 8)
        }
    }
}
