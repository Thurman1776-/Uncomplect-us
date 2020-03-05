import SwiftUI

struct ActivityIndicator: NSViewRepresentable {
    typealias NSViewType = NSProgressIndicator

    @Binding var isAnimating: Bool
    let style: NSProgressIndicator.Style

    func makeNSView(context _: NSViewRepresentableContext<ActivityIndicator>) -> NSProgressIndicator {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.style = style
        return progressIndicator
    }

    func updateNSView(_ nsView: NSProgressIndicator, context _: NSViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? nsView.startAnimation(self) : nsView.stopAnimation(self)
    }
}
