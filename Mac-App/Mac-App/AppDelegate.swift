//
//  AppDelegate.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Cocoa
import Frontend
import SwiftUI

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_: Notification) {
        configureEnviromentValues()

        let contentView = InputView { value in
            BackendAPI.dispatch(DependencyPathsAction.findUrls(for: value))

            let mainSplitView = MainSplitView(
                dependencyTreeStatus: listViewTransformer.viewInput,
                projectDetailsStatus: projectDetailsTransformer.viewInput
            )
            self.window.contentView = NSHostingView(rootView: mainSplitView)
        }

        registerSubscribers()
        window = NSWindow(
            contentRect: NSRect.zero,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    private func configureEnviromentValues() {
        DispatcherKey.defaultValue = DefaultDispatcher.self
    }
}
