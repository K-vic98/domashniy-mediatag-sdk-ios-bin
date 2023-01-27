// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mediatag",
    platforms: [.macOS(.v12), .iOS(.v12), .tvOS(.v12)],
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
          url: "https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/archive/refs/tags/1.1.0.zip",
          checksum: "0e5867216214fd5c20534e5e92222214d0099fbdd70a80cbe291c7fbd576d128"
      )
    ]
)
