//
//  CanvasGriedTrackerView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 23/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct CanvasGridTrackerView: View {

  let showBorder: Bool
  let nRows = 21
  let nCols = 18
  let starSize = 8.0
  let dayIsComplete: Set = [
    Point(r: 2, c: 0), Point(r: 2, c: 1), Point(r: 0, c: 1), Point(r: 0, c: 0),
    Point(r: 0, c: 4), Point(r: 0, c: 7), Point(r: 1, c: 5),
  ]

  var body: some View {
    Canvas {
      context,
      size in
      var star = context.resolve(Image("Star"))
      star.shading = .color(Color(.tertiaryLabel))
      for i in 0..<nRows {
        for j in 0..<nCols {
          
          let starCtx = context
          
          if i * nCols + j >= 365 {
            return
          }
          
          let frame = CGRect(
            origin: CGPoint(
              x: Double(j) * ((size.width - starSize) / Double(nCols - 1)),
              y: Double(i) * ((size.height - starSize) / Double(nRows - 1))
            ),
            size: CGSize(
              width: starSize,
              height: starSize
            )
          )
          starCtx.draw(star, in: frame)
          
        }
      }
    }
    .frame(
      maxWidth: .infinity,
      minHeight: 420,
      maxHeight: 420,
    )
    .border(showBorder ? Color(.tertiaryLabel) : .clear)
  }
}

#Preview {
  CanvasGridTrackerView(showBorder: true)
}
