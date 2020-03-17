import SwiftUI

struct DependencyItem: View {
    let dependency: DependencyTreeView.Data.Dependency

    var body: some View { mainContent.contentShape(Rectangle()) }

    private var mainContent: some View {
        VStack(alignment: .leading) {
            Text("Owner: \(dependency.owner)")
                .bold()
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()

            VStack(alignment: .leading) {
                Text("Dependency count: \(dependency.dependencies.count)")
                    .italic()
                    .foregroundColor(.yellow)
            }
        }
    }
}
