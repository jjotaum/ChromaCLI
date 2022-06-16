// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chroma",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "Chroma", targets: ["Chroma"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.1.1")
    ],
    targets: [
        .executableTarget(
            name: "Chroma",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Files", package: "Files")
        ]),
        .testTarget(
            name: "ChromaTests",
            dependencies: ["Chroma"],
            resources: [.copy("Resources")]),
    ]
)
