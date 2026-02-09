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
  let showBorder: Bool = false

  let canvasVerticalPadding: CGFloat = 16
  let canvasHorizontalPadding: CGFloat = 24
  let canvasHeight: CGFloat = 420

  let titleVerticaladding: CGFloat = 40
  let chromeHorizontalPadding: CGFloat = 24

  var body: some View {
    ZStack {
      GradientBackgroundView(showBorder: showBorder, color: habit.color)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        TitleView(
          showBorder: showBorder,
          title: habit.title,
          desc: habit.desc
        )
        .padding(.horizontal, chromeHorizontalPadding)

        ZStack {
          // For some reason, gridTracker is smaller w/o the emptySpace
          GridEmptySpace(
            showBorder: showBorder,
            canvasHeight: canvasHeight,
            horizontalPadding: canvasHorizontalPadding,
            verticalPadding: canvasVerticalPadding,
          )
          GridTrackerView(
            viewModel: GridTrackerViewModel(
              color: habit.color,
              checkedDays: habit.checkedDays,
              horizontalPadding: canvasHorizontalPadding,
              verticalPadding: canvasVerticalPadding,
              canvasHeight: canvasHeight,
            ),
            showBorder: showBorder,
          )
        }
        .padding(.bottom, canvasVerticalPadding / 2)

        GridTrackerFooterView(showBorder: showBorder)
          .padding(.horizontal, chromeHorizontalPadding)

        FooterView(color: habit.color, showBorder: showBorder)
          .padding(.horizontal, chromeHorizontalPadding)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

  }
}

#Preview {
  HabitView(
    habit: Habit(color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1])
  )
  .environment(AppState.shared)
}
