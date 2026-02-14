//
//  GradientBackgroundView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GradientBackgroundView: View {

  let showBorder: Bool
  let color: [String: Double]
  @State var startRadius: CGFloat = 0
  @State var stopRadius: CGFloat = 40

  var body: some View {
    RadialGradient(
      gradient: Gradient(colors: [
        ColorManager.toColor(color: color),
        ColorManager.toColor(color: color, briModifier: 0.67),
        Color.clear,
      ]),
      center: .top,
      startRadius: startRadius,
      endRadius: stopRadius
    )
    .drawingGroup()
    .edgesIgnoringSafeArea(.all)
    .border(showBorder ? .green : .clear)
    .onAppear {
      withAnimation(.spring(duration: 0.75)) {
        startRadius = 0
        stopRadius = 360
      }
    }
    .onDisappear {
      withAnimation(.linear(duration: 0)) {
        startRadius = 0
        stopRadius = 40
      }
    }
  }
}

#Preview {
  GradientBackgroundView(
    showBorder: false,
    color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1]
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
