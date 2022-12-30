// swift-tools-version:5.3

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
            targets: [
                "ValidatedPropertyKit"
            ]
        )
    ],
    targets: [
        .target(
            name: "ValidatedPropertyKit",
            path: "Sources"
        ),
        .testTarget(
            name: "ValidatedPropertyKitTests",
            dependencies: [
                "ValidatedPropertyKit"
            ],
            path: "Tests"
        )
    ]
)
