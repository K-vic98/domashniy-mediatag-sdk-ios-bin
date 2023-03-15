// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mediatag",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
      .library(
        name: "Mediatag",
        targets: ["MediatagSDK"]
      )
    ],
    dependencies: [],
    targets: [
      .binaryTarget(
          name: "MediatagSDK",
          url: "https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/archive/refs/tags/1.2.1.zip",
          checksum: "f249a6295318ed212a578c4740c1eb5d0434ff5b507e1419b81492cad965241c"
      )
    ]
)
