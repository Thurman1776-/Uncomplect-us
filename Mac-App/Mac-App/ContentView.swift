import SwiftUI

struct ContentView: View {

    @ObservedObject private var currentTree: TestTransformer

    init(transformer: TestTransformer) {
        self.currentTree = transformer
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            List {
                ForEach(currentTree.tree, id: \.owner) { node in
                    VStack(alignment: .leading) {
                        Text("Owner: \(node.owner)")
                            .bold()
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Dependency count: \(node.dependencies.count)")
                            .italic()
                            .foregroundColor(.yellow)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
