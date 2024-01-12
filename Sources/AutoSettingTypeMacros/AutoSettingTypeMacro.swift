import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AutoSettingTypeMacro: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    let structName = node
      .argumentList.as(LabeledExprListSyntax.self)!
      .first!
      .expression.as(StringLiteralExprSyntax.self)!
      .segments
      .first!.as(StringSegmentSyntax.self)!
      .content
      .text

    let typeString = node.argumentList
      .last!
      .expression.as(MemberAccessExprSyntax.self)!
      .base!
      .description

    return [
      """
      public struct \(raw: structName): SettingsTypeProtocol {
        public init(setting: Setting<\(raw: typeString)>) {
          self.setting = setting
        }

        public var setting: Setting<\(raw: typeString)>
      }
      """
    ]
  }
}

@main
struct AutoSettingTypePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    AutoSettingTypeMacro.self
  ]
}
