//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var viewData: ObservableData<DependencyTree.State>
    public init(viewData: ObservableData<DependencyTree.State>) {
        self.viewData = viewData
    }

    public var body: some View {
        MainSplitViewController(viewData: viewData)
    }
}
