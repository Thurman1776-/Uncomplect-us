// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Mac-App",
    products: [],
    dependencies: [
        // add your dependencies here, for example:
        // .package(url: "https://github.com/User/Project.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Mac-App",
            dependencies: [
                // add your dependencies scheme names here, for example:
                // "Project",
            ],
            path: "Mac-App"
        ),
    ]
)
