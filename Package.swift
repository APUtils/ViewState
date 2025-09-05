// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewState",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
    ],
    products: [
        .library(
            name: "ViewState",
            targets: ["ViewState"]
        ),
        .library(
            name: "RxViewState",
            targets: ["RxViewState"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/anton-plebanovich/RoutableLogger", "1.0.0"..<"3.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "ViewState",
            dependencies: [
                "RoutableLogger",
            ],
            path: "ViewState",
            exclude: ["Classes/Core/ViewStateLoader.h", "Classes/Core/ViewStateLoader.m"],
            sources: ["Classes/Core"],
            resources: [
                .process("Privacy/ViewState.Core/PrivacyInfo.xcprivacy")
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "RxViewState",
            dependencies: [
                "RoutableLogger",
                "ViewState",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxSwift", package: "RxSwift"),
            ],
            path: "ViewState",
            exclude: [],
            sources: ["Classes/RxSwift"],
            resources: [
                .process("Privacy/ViewState.RxSwift/PrivacyInfo.xcprivacy")
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
    ]
)
