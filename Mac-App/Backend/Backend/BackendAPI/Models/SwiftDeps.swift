import Yams

public struct SwiftDeps: Equatable {
    let providesTopLevel: Yams.Node.Sequence
    let dependsTopLevel: Yams.Node.Sequence

    init?(node: Yams.Node) {
        guard let providesSequence = node.mapping?["provides-top-level"]?.sequence,
            let dependsSequence = node.mapping?["depends-top-level"]?.sequence else {
            return nil
        }

        providesTopLevel = providesSequence
        dependsTopLevel = dependsSequence
    }
}
