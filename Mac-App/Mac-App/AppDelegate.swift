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
    // MARK: - Private API
    private lazy var window: NSWindow = {
        let window = NSWindow(
            contentRect: NSRect.zero,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )

        return window
    }()

    private lazy var backendSubscription = BackendSubscription(on: window)
    private let macoOSMenu = macOSMenu()
    
    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_: Notification) {
        configureEnviromentValues()
        backendSubscription.startListening()
    }

    func applicationWillTerminate(_: Notification) {
        backendSubscription.stopListening()
    }
    
    // MARK: - Private API

    private func configureEnviromentValues() {
        DispatcherKey.defaultValue = DefaultDispatcher.self
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
