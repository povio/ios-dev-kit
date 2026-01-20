// swift-tools-version:6.2
import PackageDescription

let package = Package(
  name: "PovioDevKit",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "PovioDevKit", targets: ["PovioDevKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kean/Pulse.git",    .upToNextMajor(from: "5.1.4")),
    .package(url: "https://github.com/kean/PulseLogHandler.git", .upToNextMajor(from: "5.1.0")),
    .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.4.0")),
  ],
  targets: [
    .target(
      name: "PovioDevKit",
      dependencies: [
        .product(name: "Pulse", package: "Pulse"),
        .product(name: "PulseUI", package: "Pulse"),
        .product(name: "PulseLogHandler", package: "PulseLogHandler"),
        .product(name: "Logging", package: "swift-log"),
      ],
      path: "Sources/PovioDevKit"
    ),
    .testTarget(
      name: "PovioDevKitTests",
      dependencies: ["PovioDevKit"],
      path: "Tests/PovioDevKitTests"
    )
  ]
)
