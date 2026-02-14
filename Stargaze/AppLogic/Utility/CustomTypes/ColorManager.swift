//
//  ColorMananger.swift
//  Stargaze
//
//  Created by Hazel Nishad on 8/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftUI

struct ColorManager {

  static let inverse360 = 0.002778

  static func toColor(
    color: [String: Double],
    briModifier: Double = 1,
    opacity: Double = 1
  ) -> Color {
    Color(
      hue: color["hue"]!,
      saturation: color["sat"]!,
      brightness: (color["bri"]! * (briModifier)).clamped(to: 0...1)
    )
    .opacity(opacity)
  }
  
  static func lightenDarkHues(hue: Double) -> Double {
    switch hue {
      // Dark Blue
    case (215 * self.inverse360)..<(240 * self.inverse360):
      (200 * self.inverse360)
      // Violet
    case (240 * self.inverse360)..<(265 * self.inverse360):
      (275.0 * self.inverse360)
    default:
      hue
    }
  }

  static func toColorPrimary(
    color: [String: Double],
    opacity: Double = 1
  ) -> Color {
    let hue = lightenDarkHues(hue: color["hue"]!)
    return Color(
      hue: hue,
      saturation: (color["sat"]! * 0.85).clamped(to: 0...1),
      brightness: 1
    )
    .opacity(opacity)
  }
  
  static func toColorSecondary(
    color: [String: Double],
    opacity: Double = 1
  ) -> Color {
    let hue = lightenDarkHues(hue: color["hue"]!)
    return Color(
      hue: hue,
      saturation: (color["sat"]! * 0.75).clamped(to: 0...1),
      brightness: 0.75
    )
    .opacity(opacity)
  }
}
