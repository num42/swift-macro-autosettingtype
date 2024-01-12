// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "AutoSettingType",
  platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "AutoSettingType",
      targets: ["AutoSettingType"]
    )
  ],
  dependencies: [
    .package(url: "git@github.com:num42/swift-macrotester.git", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0")
  ],
  targets: [
    .macro(
      name: "AutoSettingTypeMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .target(
      name: "AutoSettingType",
      dependencies: ["AutoSettingTypeMacros"]
    ),
    .testTarget(
      name: "AutoSettingTypeTests",
      dependencies: [
        "AutoSettingTypeMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
        .product(name: "MacroTester", package: "swift-macrotester")
      ]
    )
  ]
)
