// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ValidatedPropertyKit",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
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
