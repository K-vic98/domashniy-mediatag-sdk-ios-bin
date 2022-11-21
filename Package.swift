// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MediatagSDK",
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "MediatagSDK",
            path: "MediatagSDK.xcframework",
            checksum: "f6457cc0bc2051c1c54c09ff9d82a5e5bfa226f50279754f8bde9e011ba209b5"),
    ]
)
