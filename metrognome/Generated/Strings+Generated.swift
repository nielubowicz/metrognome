// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// %@ bpm
  internal static func bpm(_ p1: Any) -> String {
    return L10n.tr("Localizable", "%@ bpm", String(describing: p1), fallback: "%@ bpm")
  }
  /// Done
  internal static let done = L10n.tr("Localizable", "Done", fallback: "Done")
  /// Localizable.strings
  ///   metrognome
  /// 
  ///   Created by mac on 5/29/25.
  internal static let enterTempo = L10n.tr("Localizable", "Enter Tempo", fallback: "Enter Tempo")
  /// Tempo (bpm)
  internal static let tempoBpm = L10n.tr("Localizable", "Tempo (bpm)", fallback: "Tempo (bpm)")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
