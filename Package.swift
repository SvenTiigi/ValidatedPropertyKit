// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ValidatedPropertyKit",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15)
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
