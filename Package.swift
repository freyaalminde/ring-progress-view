// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ring-progress-view",
  platforms: [
    .iOS(.v15),
    .tvOS(.v15),
    .watchOS(.v8),
  ],
  products: [
    .library(name: "RingProgressView", targets: ["RingProgressView"])
  ],
  targets: [
    .target(name: "RingProgressView", path: "MKRingProgressView", exclude: ["Info.plist"])
  ]
)
