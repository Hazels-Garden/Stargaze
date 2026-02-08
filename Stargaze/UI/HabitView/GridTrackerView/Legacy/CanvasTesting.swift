//
//  CanvasTesting.swift
//  Stargaze
//
//  Created by Hazel Nishad on 23/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct CanvasTesting: View {

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
      star.shading = .color(Color(.white))
      for i in 0..<nRows {
        for j in 0..<nCols {

          let starCtx = context

//          if i * nCols + j >= 365 {
//            return
//          }

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
          let horiLine = CGRect(
            origin: CGPoint(
              x: 0,
              y: Double(i) * ((size.height - 1) / Double(nRows - 1))
            ),
            size: CGSize(
              width: size.width,
              height: 1
            )
          )
          let vertLine = CGRect(
            origin: CGPoint(
              x: Double(j) * ((size.width - 1) / Double(nCols - 1)),
              y: 0
            ),
            size: CGSize(
              width: 1,
              height: size.height
            )
          )
          starCtx.draw(star, in: frame)
          starCtx
            .stroke(
              Rectangle().path(in: horiLine),
              with: .color(Color(.quaternarySystemFill))
            )
          starCtx
            .stroke(
              Rectangle().path(in: vertLine),
              with: .color(Color(.quaternarySystemFill))
            )

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
  CanvasTesting(showBorder: true)
}
