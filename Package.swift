// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ValidatedPropertyKit",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ValidatedPropertyKit",
            targets: ["ValidatedPropertyKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ValidatedPropertyKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "ValidatedPropertyKitTests",
            dependencies: ["ValidatedPropertyKit"],
            path: "Tests"
        ),
    ]
)
