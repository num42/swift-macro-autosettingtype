import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct AutoSettingTypePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    AutoSettingTypeMacro.self
  ]
}
