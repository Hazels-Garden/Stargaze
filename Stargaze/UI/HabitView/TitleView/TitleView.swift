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
    VStack {
      Text(title).SGTitle().fontWidth(.expanded)
      Text(desc)
        .SGNormal()
        .foregroundStyle(.secondary)
    }
    .border(showBorder ? .purple : .clear)
    .padding(.top, -16)
    .frame(maxHeight: .infinity)
    .border(showBorder ? .purple : .clear)
  }
}

#Preview {
  TitleView(showBorder: false, title: "Run 5k", desc: "9:00AM • Run at least 5k everyday")
}
