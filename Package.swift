// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chroma",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "Chroma", targets: ["Chroma"]),
        .library(name: "ChromaLibrary", targets: ["ChromaLibrary"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", .exact("0.1.0")),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Chroma",
            dependencies: ["ChromaLibrary"]),
        .target(
            name: "ChromaLibrary",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Files", package: "Files")
        ]),
        .testTarget(
            name: "ChromaTests",
            dependencies: ["ChromaLibrary"],
            resources: [.copy("Resources")]),
    ]
)
