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
  let canvasHeight: CGFloat
  let horizontalPadding: CGFloat
  let verticalPadding: CGFloat

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.yellow) : .clear)
      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.yellow) : .clear)
        .frame(
          maxWidth: .infinity,
          minHeight: canvasHeight,
          maxHeight: canvasHeight,
        )
        .padding(horizontal: horizontalPadding, vertical: verticalPadding)
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: canvasHeight + (2 * verticalPadding)
    )
  }
}

#Preview {
  GridEmptySpace(
    showBorder: false,
    canvasHeight: 420,
    horizontalPadding: 24,
    verticalPadding: 16
  )
  .environment(AppState.shared)
}
