//
//  HabitView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct HabitView: View {

  let habit: Habit
  // For debug purposes only. Please turn this off when shipping!
  let showBorder = false
  let canvasBottomPadding: CGFloat = 16

  var body: some View {
    ZStack {
      GradientBackgroundView(showBorder: showBorder, color: habit.color)
        .ignoresSafeArea()

      // Main Content
      VStack(spacing: 0) {
        TitleView(showBorder: showBorder, title: habit.title, desc: habit.desc)

        GridEmptySpace(
          showBorder: showBorder,
          canvasPadding: canvasBottomPadding
        )
        GridTrackerFooterView(showBorder: showBorder)

        FooterView(color: habit.color, showBorder: showBorder)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.horizontal, 24)

      GridTrackerView(showBorder: showBorder)
        .padding(.bottom, 2 * canvasBottomPadding)
    }

  }
}

#Preview {
  HabitView(habit: Habit())
}
