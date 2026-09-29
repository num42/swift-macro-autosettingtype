# AutoSettingType

`#AutoSettingType` is a Swift macro that generates a typed setting wrapper struct conforming to `SettingTypeProtocol`.

## Requirements

- Swift 6.3 toolchain or later (tested with Xcode 27)
- Platforms: macOS 14, iOS 13, tvOS 13, watchOS 6, macCatalyst 13

## Installation

Add this package to your SwiftPM dependencies and import `AutoSettingType` in the files where you use the macro.

## Usage

```swift
import AutoSettingType

public enum SettingTypes {
  #AutoSettingType(name: "Allow", type: Set<Entry.ID>.self)
}
```

Generated:

```swift
public enum SettingTypes {
  public struct Allow: SettingTypeProtocol {
    public init(setting: Setting<Set<Entry.ID>>) {
      self.setting = setting
    }

    public var setting: Setting<Set<Entry.ID>>
  }
}
```

## Notes

- `name` must be a plain string literal; it becomes the struct name.
- `type` must be written as `TypeName.self`.
- The generated code uses `SettingTypeProtocol` and `Setting`, so the file must import the module that declares them.
- The macro reports an error for each unmet requirement.
