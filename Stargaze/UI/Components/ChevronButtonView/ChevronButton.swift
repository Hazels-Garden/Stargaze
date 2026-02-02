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

  let buttonType: ButtonType

  var buttonColor: Color {
    switch buttonType {
    case .small:
      Color(.secondaryLabel)
    case .large:
      Color(.quaternaryLabel)
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

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .labelStyle(.iconOnly)
      .font(.system(size: buttonType == .small ? 13 : 24))
      .fontWeight(.bold)
      .foregroundStyle(
        configuration.isPressed ? pressedButtonColor : buttonColor
      )
  }
}
