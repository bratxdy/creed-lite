// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Creed-Lite",
    platforms: [.iOS(.v16), .tvOS(.v16), .watchOS(.v9)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Creed-Lite",
            targets: ["Creed-Lite"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections.git", from: "1.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.3"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Creed-Lite",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "Collections", package: "swift-collections"),
            ],
            resources: [
                .copy("Responses/Sample Data/feats.json"),
                .copy("Responses/Sample Data/leader_board.json"),
            ]
        ),
        .testTarget(
            name: "CreedTests",
            dependencies: [
                "Creed-Lite",
                .product(name: "CustomDump", package: "swift-custom-dump")
            ])
    ]
)
