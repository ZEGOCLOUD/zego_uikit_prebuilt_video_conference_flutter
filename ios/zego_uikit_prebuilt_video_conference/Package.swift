// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "zego_uikit_prebuilt_video_conference",
    platforms: [.iOS("13.0")],
    products: [.library(name: "zego-uikit-prebuilt-video-conference", targets: ["zego_uikit_prebuilt_video_conference"])],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "zego_uikit_prebuilt_video_conference",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            cSettings: [.headerSearchPath("include/zego_uikit_prebuilt_video_conference")]
        )
    ]
)
