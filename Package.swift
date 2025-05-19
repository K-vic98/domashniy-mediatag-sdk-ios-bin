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
          checksum: "a110b312c900e33234ca621c1a2ac1b3c0902d9050a2174bc75ee4e6f57cb370"
      )
    ]
)
