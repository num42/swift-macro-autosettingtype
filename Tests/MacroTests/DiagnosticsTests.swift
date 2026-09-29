internal import MacroTestHelper
internal import SwiftSyntaxMacrosGenericTestSupport
internal import Testing

#if canImport(AutoSettingTypeMacros)
  import AutoSettingTypeMacros

  @Suite
  struct AutoSettingTypeDiagnosticsTests {
    @Test func interpolatedNameThrowsError() {
      MacroTestHelper.assertMacroExpansion(
        """
        #AutoSettingType(name: "Allow\\(1)", type: Int.self)
        """,
        expandedSource: """
          #AutoSettingType(name: "Allow\\(1)", type: Int.self)
          """,
        diagnostics: [
          .init(
            message: AutoSettingTypeMacro.MacroDiagnostic.requiresNameLiteral.message,
            line: 1,
            column: 24
          )
        ],
        macros: testMacros
      )
    }

    @Test func typeWithoutSelfThrowsError() {
      MacroTestHelper.assertMacroExpansion(
        """
        #AutoSettingType(name: "Allow", type: someType)
        """,
        expandedSource: """
          #AutoSettingType(name: "Allow", type: someType)
          """,
        diagnostics: [
          .init(
            message: AutoSettingTypeMacro.MacroDiagnostic.requiresTypeArgument.message,
            line: 1,
            column: 39
          )
        ],
        macros: testMacros
      )
    }
  }
#endif
