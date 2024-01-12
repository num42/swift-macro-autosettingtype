import AutoSettingType

public protocol SettingsTypeProtocol {}
public struct Setting<T> {
  let variable: T
}

public enum Entry {
  public struct Identifier: Hashable {}
}

// examples
public enum SettingTypes {
  #AutoSettingType(name: "AllowThis", type: Bool.self)

  #AutoSettingType(name: "AndThis", type: Setting<Entry.Identifier>.self)

  #AutoSettingType(name: "AndThat", type: Setting<Int>.self)

  #AutoSettingType(name: "AllowThese", type: [Int].self)

  #AutoSettingType(name: "AllowThose", type: [Entry.Identifier].self)
}
