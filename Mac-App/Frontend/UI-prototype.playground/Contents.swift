import Frontend
import PlaygroundSupport
import SwiftUI

let itemView = DependencyItemView(
    dependency: DependencyTree.State.Dependency(owner: "Daniel", dependencies: ["orange", "apple", "banana"]),
    isExpanded: true
)
struct ContentView: View {
    var body: some View {
        VStack {
            itemView
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
