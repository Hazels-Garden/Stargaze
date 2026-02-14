//
//  StatCol.swift
//  Stargaze
//
//  Created by Hazel Nishad on 13/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct StatCol: View {
  let text: String
  let statValue: Int
  let postFix: String
  
  var body: some View {
    VStack {
      Text(text)
        .SGXLarge()
        .fontWidth(.compressed)
        .foregroundStyle(.secondary)
      Text("\(statValue)\(postFix)")
        .fontWeight(.medium)
        .SGTitle()
        .fontWidth(.compressed)
    }
    .frame(maxWidth: 96)
  }
}

#Preview {
  StatCol(text: "This Year", statValue: 12, postFix: "")
}
