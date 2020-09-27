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
    private var window: NSWindow!
    private var backendSubscription: BackendSubscription!
    private let macoOSMenu = macOSMenu()

    func applicationDidFinishLaunching(_: Notification) {
        configureEnviromentValues()

        window = NSWindow(
            contentRect: NSRect.zero,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        backendSubscription = BackendSubscription(on: window)
        backendSubscription.startListening()
    }

    private func configureEnviromentValues() {
        DispatcherKey.defaultValue = DefaultDispatcher.self
    }

    func applicationWillTerminate(_: Notification) {
        backendSubscription.stopListening()
    }
}

// MARK: Akward macOS menu actions plugging

/// Actions from menus will be forwarded to a designated data type to avoid unnecessary clutter in the
/// AppDelegate.
/// This mechanism (linking actions from `Main.storyboard`) is very strange but attempting to do this
/// only with code is surprinsigly complicated. WTF Apple?

extension AppDelegate {
    @IBAction func triggerNewSearch(_ sender: NSMenuItem) {
        macoOSMenu.triggerNewSearch(sender)
    }
}
