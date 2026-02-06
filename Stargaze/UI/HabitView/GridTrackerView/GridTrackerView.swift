//
//  GridTrackerView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 23/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GridTrackerView: View {

  let showBorder: Bool

  let nRows = 21
  let nCols = 18
  let starSize = 8.0

  let canvasHeight: CGFloat = 420
  let horizontalPadding: CGFloat = 24

  @State private var selectedStarGrid: CGRect?
  let dayIsComplete: Set = [
    Point(r: 2, c: 0), Point(r: 2, c: 1), Point(r: 0, c: 1), Point(r: 0, c: 0),
    Point(r: 0, c: 4), Point(r: 0, c: 7), Point(r: 1, c: 5),
  ]

  var body: some View {
    ZStack {
      GeometryReader { geom in
        TimelineView(.animation) { timeline in
          Canvas { context, size in

            // TODO: Make random stars "shine" periodically
            //          let now = timeline.date.timeIntervalSinceReferenceDate
            //          let angle = now.remainder(dividingBy: 3) * 120

            let canvasOrigin = CGPoint(
              x: horizontalPadding,
              y: (size.height / 2) - (canvasHeight / 2)
            )

            for i in 0..<nRows {
              for j in 0..<nCols {

                if i * nCols + j >= 365 {
                  return
                }

                drawStarGrid(
                  context: context,
                  size: size,
                  canvasOrigin: canvasOrigin,
                  angle: Double.random(in: 0...45),
                  row: i,
                  col: j
                )

              }
            }
          }
          .border(showBorder ? Color(.tertiaryLabel) : .clear)
          .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
              .onChanged { value in

              }
          )
        }
      }

      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.tertiaryLabel) : .clear)
        .frame(
          maxWidth: .infinity,
          minHeight: canvasHeight,
          maxHeight: canvasHeight,
        )
        .padding(.horizontal, horizontalPadding)
    }
  }

  func drawStarGrid(
    context: GraphicsContext,
    size: CGSize,
    canvasOrigin: CGPoint,
    angle: Double,
    row: Int,
    col: Int
  ) {

    var star = context.resolve(Image("Star"))
    star.shading = .color(Color(.tertiaryLabel))

    let frame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: CGSize(width: starSize, height: starSize)
    )
    let canvasWidth = size.width - (2 * horizontalPadding)
    var starContext = context

    // Moving them into place
    starContext.translateBy(
      x: canvasOrigin.x
        + (Double(col) * ((canvasWidth - starSize) / Double(nCols - 1))),
      y: canvasOrigin.y
        + (Double(row) * ((canvasHeight - starSize) / Double(nRows - 1)))
    )

    // Moving the pivot to the center before rotating them
    starContext.translateBy(x: (starSize / 2), y: (starSize / 2))
    starContext.rotate(by: .degrees(angle))
    starContext.translateBy(x: -(starSize / 2), y: -(starSize / 2))

    starContext.draw(star, in: frame)

    //    starContext.stroke(Rectangle().path(in: frame), with: .foreground)
  }
}

#Preview {
  GridTrackerView(showBorder: true)
}
