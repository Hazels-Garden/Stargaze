//
//  ChevronButton.swift
//  Stargaze
//
//  Created by Hazel Nishad on 20/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct ChevronButton: ButtonStyle {

  enum ButtonType {
    case small
    case large
  }

  enum ButtonDir {
    case leading
    case trailing
  }

  let buttonType: ButtonType
  let buttonDir: ButtonDir
  let isDisabled: Bool

  var buttonColor: Color {
    switch isDisabled {
    case true:
      Color(white: 0.05)
    case false:
      switch buttonType {
      case .small:
        Color(.tertiaryLabel)
      case .large:
        Color(.quaternaryLabel)
      }
    }
  }
  var pressedButtonColor: Color {
    switch buttonType {
    case .small:
      Color(.label)
    case .large:
      Color(.secondaryLabel)
    }
  }
  var smallButtonPaddingDir: Edge.Set {
    switch buttonDir {
    case .leading:
      .trailing
    case .trailing:
      .leading
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .labelStyle(.iconOnly)
      .font(.system(size: buttonType == .small ? 13 : 24))
      // Increasing small button touch target
      .padding(smallButtonPaddingDir, buttonType == .small ? 12 : 0)
      .padding(.vertical, buttonType == .small ? 8 : 0)
      .fontWeight(.bold)
      .foregroundStyle(
        configuration.isPressed ? pressedButtonColor : buttonColor
      )
  }
}
