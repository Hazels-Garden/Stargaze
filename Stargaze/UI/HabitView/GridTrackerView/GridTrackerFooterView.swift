//
//  GridTrackerFooterView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GridTrackerFooterView: View {

  let showBorder: Bool

  var body: some View {
    HStack {
      HStack {
        Button("Previous Year", systemImage: "chevron.left") {

        }
        .buttonStyle(ChevronButton(buttonType: .small))
        Text("2026").SGMono().foregroundStyle(.secondary)
        Button("Next Year", systemImage: "chevron.right") {

        }
        .buttonStyle(ChevronButton(buttonType: .small))
      }
      Spacer()
      Text("320 days left").SGMono().foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity)
    .border(showBorder ? .green : .clear)
    .padding(.top, 16)
    .border(showBorder ? .purple : .clear)
  }
}

#Preview {
  GridTrackerFooterView(showBorder: false)
}
