import Backend
import Cocoa
import ReSwift
import SwiftUI

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let subscriber = TestTransformer()

    func applicationDidFinishLaunching(_: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(transformer: subscriber)
        BackendAPI.dispatch(DependencyPathsAction.findUrls(for: "Mac-App"))
        BackendAPI.subscribe(subscriber)

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}

// Testing UI rendering only - Approach still needs to be defined

final class TestTransformer: StoreSubscriber, ObservableObject {
    typealias StoreSubscriberStateType = AppState
    @Published private (set)var tree = [DependencyTree]()

    func newState(state: AppState) {
        DispatchQueue.main.async {
            self.tree = state.dependencyGraphState.tree
        }
    }
}
