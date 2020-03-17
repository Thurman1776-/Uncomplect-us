import SwiftUI

struct DependencyItem: View {
    let dependency: DependencyTreeView.Data.Dependencies

    var body: some View {
        VStack(alignment: .leading) {
            Text("Owner: \(dependency.owner)")
                .bold()
                .foregroundColor(.gray)
            Spacer()
            Text("Dependency count: \(dependency.dependencies.count)")
                .italic()
                .foregroundColor(.yellow)
        }
    }
}
