// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LibSGR",
  products: [
    .library(
      name: "LibSGR",
      targets: [
        "LibSGR",
      ]
    ),
  ],
  targets: [
    .target(
      name: "libsg"
    ),
    .target(
      name: "LibSGR",
      dependencies: [
        "libsg",
      ]
    ),
    .testTarget(
      name: "LibSGRTests",
      dependencies: [
        "LibSGR",
      ]
    ),
  ]
)
