//
//  PeekStatsView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 13/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct PeekStatsView: View {
  let userStats: UserStats

  var body: some View {
    ZStack {
      HStack(alignment: .center, spacing: 0) {
        Spacer()
        StatCol(
          text: "All Time",
          statValue: userStats.totalAllTime,
          postFix: ""
        )
        Spacer()
        Rectangle()
          .fill(.tertiary)
          .frame(width: 1, height: 32)
          .padding(.top, 24)
        Spacer()
        StatCol(
          text: "Best Streak",
          statValue: userStats.bestStreak,
          postFix: ""
        )
        Spacer()
      }
    }
  }
}

#Preview {
  PeekStatsView(userStats: UserStats.shared)
}
