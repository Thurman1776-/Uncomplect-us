// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Mac-App",
    products: [],
    dependencies: [
        .package(url: "https://github.com/ReSwift/ReSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "Mac-App",
            dependencies: [
                "ReSwift",
            ],
            path: "Mac-App"
        ),
    ]
)
