// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Mac-App",
    products: [],
    dependencies: [
        .package(url: "https://github.com/ReSwift/ReSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.1")),
    ],
    targets: [
        .target(
            name: "Mac-App",
            dependencies: [
                "ReSwift",
            ],
            path: "Mac-App"
        ),
        .target(
            name: "Mac-AppTests",
            dependencies: [
                "Quick",
                "Nimble",
            ],
            path: "Mac-AppTests"
        ),
    ]
)
