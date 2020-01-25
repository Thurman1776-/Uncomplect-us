// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Backend",
    products: [],
    dependencies: [
        .package(url: "https://github.com/ReSwift/ReSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.1")),
    ],
    targets: [
        .target(
            name: "Backend",
            dependencies: [
                "ReSwift",
            ],
            path: "Backend"
        ),
        .target(
            name: "BackendTests",
            dependencies: [
                "Quick",
                "Nimble",
            ],
            path: "BackendTests"
        ),
    ]
)
