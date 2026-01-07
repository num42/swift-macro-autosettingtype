import MacroTester
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

#if canImport(AutoSettingTypeMacros)
  import AutoSettingTypeMacros

  let testMacros: [String: Macro.Type] = [
    "AutoSettingType": AutoSettingTypeMacro.self
  ]

  @Suite struct AutoSettingTypeTests {
    @Test func standardType() {
      MacroTester.testMacro(macros: testMacros)
    }

    @Test func simpleGenericType() {
      MacroTester.testMacro(macros: testMacros)
    }

    @Test func advancedGenericType() {
      MacroTester.testMacro(macros: testMacros)
    }

    @Test func array() {
      MacroTester.testMacro(macros: testMacros)
    }

    @Test func arrayWithProperty() {
      MacroTester.testMacro(macros: testMacros)
    }
  }
#endif
