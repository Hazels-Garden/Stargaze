//
//  GridTrackerView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GridTrackerView: View {

  let showBorder: Bool
  let nRows = 21
  let nCols = 18
  let dayIsComplete: Set = [
    Point(r: 2, c: 0), Point(r: 2, c: 1), Point(r: 0, c: 1), Point(r: 0, c: 0),
    Point(r: 0, c: 4), Point(r: 0, c: 7), Point(r: 1, c: 5),
  ]

  var body: some View {
    Grid {
      ForEach(0..<nRows, id: \.self) { r in
        GridRow {
          ForEach(0..<nCols, id: \.self) { c in
            Circle()
              .frame(width: 5)
              .foregroundStyle(
                dayIsComplete
                  .contains(Point(r: r, c: c)) ? .primary : .tertiary
              )
            Spacer()
              .frame(maxWidth: c == nCols - 1 ? 0 : .infinity)
              .border(showBorder ? .blue : .clear)
          }
        }
      }
    }
    .frame(
      maxWidth: .infinity,
      minHeight: 420,
      maxHeight: 420,
    )
    .border(showBorder ? .purple : .clear)
  }
}

#Preview {
  GridTrackerView(showBorder: false)
}
