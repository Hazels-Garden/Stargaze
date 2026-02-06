//
//  GridEmptySpace.swift
//  Stargaze
//
//  Created by Hazel Nishad on 23/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GridEmptySpace: View {

  let showBorder: Bool
  let canvasHeight: CGFloat = 420
  let horizontalPadding: CGFloat = 0
  let canvasPadding: CGFloat

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.tertiaryLabel) : .clear)
      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.tertiaryLabel) : .clear)
        .frame(
          maxWidth: .infinity,
          minHeight: canvasHeight,
          maxHeight: canvasHeight,
        )
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, canvasPadding)
    }
  }
}

#Preview {
  GridEmptySpace(showBorder: true, canvasPadding: 16)
}
