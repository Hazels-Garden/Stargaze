//
//  TextButtonStyle.swift
//  Stargaze
//
//  Created by Hazel Nishad on 13/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct TextButtonStyle: ButtonStyle {

  let buttonShape: some Shape = RoundedRectangle(
    cornerRadius: 14,
    style: .continuous
  )

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      .background(.ultraThinMaterial)
      .foregroundStyle(.secondary)
      .clipShape(buttonShape)
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.smooth(duration: 0.2), value: configuration.isPressed)
  }
}
