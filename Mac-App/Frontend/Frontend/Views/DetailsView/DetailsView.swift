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
            HStack(spacing: 8) {
                VStack(spacing: 4) {
                    VStack {
                        Text("Heaviest dependency: ")
                            .foregroundColor(.lightBlue)
                            .font(.system(.headline))
                        Text(state.heaviestDependency)
                            .underline()
                            .font(.system(.subheadline))
                            .foregroundColor(.white)
                    }

                    Text("Total dependencies found: \(state.totalDependenciesFound)")
                        .bold()
                        .foregroundColor(.lightBlue)
                        .font(.system(.body))

                    Text("Files scanned: \(state.paths.count)")
                        .bold()
                        .foregroundColor(.lightGreen)
                        .font(.system(.body))
                }

                PlainList(
                    titles: state.paths.map { String($0.absoluteString) },
                    itemsColor: .yellow,
                    truncationMode: .middle
                )
            }
            .padding([.leading, .top, .trailing, .bottom], 8)
        case let .failure(errorMessage):
            Text(errorMessage)
                .bold()
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom], 8)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            projectDetailsStatus: Observable<ProjectDetails.Status>(
                ProjectDetails.Status.success(
                    state: .init(
                        heaviestDependency: "Heaviest",
                        totalDependenciesFound: 100_000,
                        paths: [
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                            URL(string: "www.google.com")!,
                        ],
                        failure: nil
                    )
                )
            )
        )
    }
}
