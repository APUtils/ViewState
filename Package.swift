// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewState",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
    ],
    products: [
        .library(
            name: "ViewState",
            targets: ["ViewState"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ViewState",
            dependencies: [],
            path: "ViewState/Classes",
            exclude: ["ViewStateLoader.h", "ViewStateLoader.m"]),
    ]
)
