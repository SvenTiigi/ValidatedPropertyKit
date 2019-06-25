// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "ValidatedPropertyKit",
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
