import MacroTester
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(AutoSettingTypeMacros)
  import AutoSettingTypeMacros

  let testMacros: [String: Macro.Type] = [
    "AutoSettingType": AutoSettingTypeMacro.self
  ]

final class AutoSettingTypeTests: XCTestCase {
  func testStandardType() throws {
    testMacro(macros: testMacros)
  }

  func testSimpleGenericType() throws {
    testMacro(macros: testMacros)
  }

  func testAdvancedGenericType() throws {
    testMacro(macros: testMacros)
  }

  func testArray() throws {
    testMacro(macros: testMacros)
  }

  func testArrayWithProperty() throws {
    testMacro(macros: testMacros)
  }
}
#endif
