//
//  TitleView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct TitleView: View {

  let showBorder: Bool
  let title: String
  let desc: String

  var body: some View {
    VStack(spacing: 8) {
      Text(title)
        .SGTitle()
        .fontWidth(.expanded)
        .lineLimit(1)
      
      Text(desc)
        .SGNormal()
        .foregroundStyle(.secondary)
        .lineLimit(2)
    }
    .border(showBorder ? .purple : .clear)
    .frame(
      minHeight: 108,
      maxHeight: 108
    )
    .border(showBorder ? .purple : .clear)
  }
}

#Preview {
  TitleView(
    showBorder: true,
    title: "Run 5k",
    desc: "9:00AM • Run at least 5km"
  )
  .environment(AppState.shared)
}
