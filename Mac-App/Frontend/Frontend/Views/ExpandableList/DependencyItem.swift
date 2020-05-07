import SwiftUI

struct DependencyItem: View {
    let dependency: DependencyTree.Data.Dependency
    let isExpanded: Bool

    var body: some View {
        HStack {
            mainContent
            Spacer()
        }
        .contentShape(Rectangle())
    }

    private var mainContent: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Owner: \(dependency.owner)")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("Dependency count: \(dependency.dependencies.count)")
                    .font(.footnote)
                    .foregroundColor(.white)
                Spacer()
            }

            if isExpanded {
                VStack(alignment: .leading) {
                    dependencyList
                }
            }
        }
    }

    private var dependencyList: some View {
        ForEach(dependency.dependencies, id: \.id) { dep in
            Text(dep)
                .font(.body)
                .italic()
                .foregroundColor(.yellow)
        }
    }
}

// TODO: Move to shareable framework

extension String: Identifiable {
    public var id: Int { hashValue }
}
