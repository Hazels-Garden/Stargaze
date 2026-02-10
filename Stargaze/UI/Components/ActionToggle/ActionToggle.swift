//
//  ActionToggle.swift
//  Stargaze
//
//  Created by Hazel Nishad on 20/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct ActionToggle: ToggleStyle {

  let color: [String: Double]
  var buttonColor: Color {
    // When opacity is 0, User did not select a color
    switch color["opa"]!
    {
    case 0:
      Color(
        hue: 0,
        saturation: 0,
        brightness: 0.5
      )
    default:
      Color(
        hue: color["hue"]!,
        saturation: color["sat"]!,
        brightness: color["bri"]!
      )
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    Button {
      withAnimation(.smooth) {
        configuration.isOn.toggle()
      }
    } label: {
      configuration.label
        .padding(.vertical, 18)
        .background(
          configuration.isOn
            ? buttonColor
            : buttonColor
              .opacity(0.25)
        )
        .foregroundStyle(
          configuration.isOn ? .primary
            .opacity(0.8) : Color(.secondaryLabel)
            .opacity(0.8)
        )
        .clipShape(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .animation(.smooth, value: configuration.isOn)

    }
    .buttonStyle(.plain)
  }
}
