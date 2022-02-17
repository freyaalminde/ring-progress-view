// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MKRingProgressView",
    platforms: [.iOS(.v10), .tvOS(.v10)],
    products: [
        .library(name: "MKRingProgressView", targets: ["MKRingProgressView"])
    ],
    targets: [
        .target(name: "MKRingProgressView", path: "MKRingProgressView")
    ]
)
