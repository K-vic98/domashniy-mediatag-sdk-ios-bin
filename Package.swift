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
          url: "https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/archive/refs/tags/1.2.5.zip",
          checksum: "b698b80737767b23411d57a109662a6a5ca475c309c3c9449698554be880966e"
      )
    ]
)
