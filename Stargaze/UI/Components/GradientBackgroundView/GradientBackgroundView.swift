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
  let color: UInt
  
    var body: some View {
      RadialGradient(
        gradient: Gradient(colors: [
          Color(hex: color),
          // TODO: Probably a better way to do this
          Color(hex: color).mix(with: .black, by: 0.3),
          Color.clear,
        ]),
        center: .top,
        startRadius: 40,
        endRadius: 400
      )
      .edgesIgnoringSafeArea(.all)
      .border(showBorder ? .green : .clear)
    }
}

#Preview {
  GradientBackgroundView(showBorder: false, color: 0xD78725)
}
