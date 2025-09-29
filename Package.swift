// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let name = "AutoSettingType"

let package = Package(
  name: name,
  platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: name,
      targets: [name]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/num42/swift-macrotester.git", from: "2.1.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0")
  ],
  targets: [
    .macro(
      name: "\(name)Macros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .target(
      name: name,
      dependencies: [.target(name: "\(name)Macros")]
    ),
    .testTarget(
      name: "\(name)Tests",
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
        .product(name: "MacroTester", package: "swift-macrotester")
      ],
      resources: [.copy("Resources")]
    )
  ]
)
