//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var viewData: ObservableData<DependencyTreeView.State>
    public init(viewData: ObservableData<DependencyTreeView.State>) {
        self.viewData = viewData
    }

    public var body: some View {
        MainSplitViewController(viewData: viewData)
    }
}
