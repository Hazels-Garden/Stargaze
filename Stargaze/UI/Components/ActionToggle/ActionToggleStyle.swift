//
//  ActionToggleStyle.swift
//  Stargaze
//
//  Created by Hazel Nishad on 20/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct ActionToggleStyle: ToggleStyle {

  let color: [String: Double]
  var buttonColorVal: [String: Double] {
    // When opacity is 0, User did not select a color
    switch color["opa"]!
    {
    case 0:
      ["hue": 0, "sat": 0, "bri": 0.5]
    default:
      color
    }
  }
  var buttonColor: Color {
    ColorManager.toColor(color: buttonColorVal)
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
          configuration.isOn
            ? .primary
              .opacity(0.8)
            : Color(.secondaryLabel)
              .opacity(0.8)
        )
        .clipShape(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay {
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(
              configuration.isOn
                ? ColorManager
                  .toColor(color: buttonColorVal, briModifier: 2)
                : ColorManager
                  .toColor(color: buttonColorVal, briModifier: 1.4).opacity(
                    0.25
                  ),
              lineWidth: configuration.isOn ? 2 : 1,
            )
        }
        .animation(.smooth, value: configuration.isOn)

    }
    .buttonStyle(.plain)
  }
}
