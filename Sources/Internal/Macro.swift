public import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct AutoSettingTypeMacro: DeclarationMacro {
  public enum MacroDiagnostic: String, DiagnosticMessage {
    case requiresNameLiteral = "#AutoSettingType requires the name as a plain string literal"
    case requiresTypeArgument = "#AutoSettingType requires the type in the form 'TypeName.self'"

    public var message: String { rawValue }

    public var diagnosticID: MessageID {
      MessageID(domain: "AutoSettingType", id: rawValue)
    }

    public var severity: DiagnosticSeverity { .error }
  }

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let nameExpression = node.arguments.first?.expression,
      let nameLiteral = nameExpression.as(StringLiteralExprSyntax.self),
      nameLiteral.segments.count == 1,
      let structName = nameLiteral.segments.first?.as(StringSegmentSyntax.self)?.content.text,
      !structName.isEmpty
    else {
      throw DiagnosticsError(diagnostics: [
        Diagnostic(
          node: node.arguments.first.map { Syntax($0.expression) } ?? Syntax(node),
          message: MacroDiagnostic.requiresNameLiteral
        )
      ])
    }

    guard
      node.arguments.count == 2,
      let typeExpression = node.arguments.last?.expression.as(MemberAccessExprSyntax.self),
      typeExpression.declName.baseName.tokenKind == .keyword(.self),
      let typeBase = typeExpression.base
    else {
      throw DiagnosticsError(diagnostics: [
        Diagnostic(
          node: Syntax(node.arguments.last?.expression ?? nameExpression),
          message: MacroDiagnostic.requiresTypeArgument
        )
      ])
    }

    let typeString = typeBase.trimmedDescription

    return [
      """
      public struct \(raw: structName): SettingTypeProtocol {
        public init(setting: Setting<\(raw: typeString)>) {
          self.setting = setting
        }

        public var setting: Setting<\(raw: typeString)>
      }
      """
    ]
  }
}
