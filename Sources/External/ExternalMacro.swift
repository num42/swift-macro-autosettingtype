@freestanding(declaration, names: arbitrary)
public macro AutoSettingType<T>(name: String, type: T.Type) =
  #externalMacro(module: "AutoSettingTypeMacros", type: "AutoSettingTypeMacro")
