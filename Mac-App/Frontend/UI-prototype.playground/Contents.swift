import Frontend
import PlaygroundSupport
import SwiftUI

let itemView = DependencyItemsView(
    dependency: DependencyTree.State.Dependency(owner: "Daniel", dependencies: ["orange", "apple", "banana"]),
    isExpanded: true
)

let searchBar = SearchBar(placeholder: "filter items...")

struct ContentView: View {
    var body: some View {
        VStack {
            searchBar
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
