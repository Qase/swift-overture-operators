// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "overture-operators",
    platforms: [
        .iOS(.v14)
//        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OvertureOperators",
            targets: ["OvertureOperators"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Overture", url: "https://github.com/pointfreeco/swift-overture.git", from: "0.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OvertureOperators",
            dependencies: [
                "Overture"
            ]
        ),
        .testTarget(
            name: "OvertureOperatorsTests",
            dependencies: [
                "OvertureOperators"
            ]
        ),
    ]
)
