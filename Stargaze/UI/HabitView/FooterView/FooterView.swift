//
//  FooterView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftData
import SwiftUI

struct FooterView: View {

  let habit: Habit
  let showBorder: Bool
  @Environment(\.modelContext) var modelContext
  @Environment(AppState.self) private var appState
  @State var daysRemaining: Int = 365
  @State var resetDateButtonIsVisible: Bool = false
  @State var checkedDaysSet: Set<DateComponents> = Set()
  @Binding var isPresented: Bool

  var disablePreviousChevron: Bool {
    let selectedDate = appState.getDateOnly(from: appState.selectedDate)
    return selectedDate.day == 1 && selectedDate.month == 1
  }
  var disableNextChevron: Bool {
    let selectedDate = appState.getDateOnly(from: appState.selectedDate)
    return selectedDate.day == 31 && selectedDate.month == 12
  }
  var disableActionToggle: Bool {
    return appState.selectedDate.dayOfYear > appState.currentDate.dayOfYear
  }

  var body: some View {

    let isChecked = ToggleBinding(
      habit: habit,
      modelContext: modelContext
    ).isChecked

    VStack(spacing: 10) {
      HStack(spacing: 16) {

        Button("Previous Day", systemImage: "chevron.left") {
          appState.selectedDate.toPreviousDay()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .large,
            buttonDir: .leading,
            isDisabled: disablePreviousChevron
          )
        )
        .disabled(disablePreviousChevron)

        Toggle(isOn: isChecked) {
          ToggleTextView(text: appState.formattedDateFromSelectedDate())
            .animation(.smooth(duration: 0.25), value: appState.selectedDate)
        }
        .toggleStyle(ActionToggle(color: habit.color))
        .border(showBorder ? .purple : .clear)
        .disabled(disableActionToggle)

        Button("Next Day", systemImage: "chevron.right") {
          appState.selectedDate.toNextDay()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .large,
            buttonDir: .trailing,
            isDisabled: disableNextChevron
          )
        )
        .disabled(disableNextChevron)

      }
      // Padding between grid view and footer
      .padding(.top, 40)

      FooterStatsView(habit: habit, showBorder: showBorder)

      Button {
        appState.selectedDate = appState.currentDate
        appState.selectedYear = appState.currentYear
      } label: {
        Text("Reset to current date")
          .SGNormal()
          .fontWidth(.condensed)
          .foregroundStyle(ColorManager.toColorSecondary(color: habit.color))
      }
      .opacity(resetDateButtonIsVisible ? 1 : 0)
      .animation(.smooth, value: resetDateButtonIsVisible)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .contentShape(Rectangle())
    .border(showBorder ? .purple : .clear)
    .onAppear {
      createCheckedDaysSet()
      resetDateButtonIsVisible = (appState.selectedDate != appState.currentDate)
    }
    .onChange(of: appState.selectedDate) {
      resetDateButtonIsVisible = (appState.selectedDate != appState.currentDate)
    }
    .onChange(of: habit.checkedDays) {
      createCheckedDaysSet()
    }
    .gesture(
      DragGesture(minimumDistance: 24, coordinateSpace: .local).onChanged {
        value in
        let verticalAmount = value.translation.height
        if verticalAmount < 0 && !isPresented {
          isPresented = true
        }
        if verticalAmount > 0 && isPresented {
          isPresented = false
        }
      }
    )
  }

  func createCheckedDaysSet() {
    for checkedDay in habit.checkedDays {
      let checkedDate = appState.getDateOnly(from: checkedDay.date)
      checkedDaysSet.insert(checkedDate)
    }
  }

}

#Preview {
  FooterView(
    habit: Habit(
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_335_400)),  // 2026-01-02
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_421_800)),  // 2026-01-03
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_853_800)),  // 2026-01-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_285_800)),  // 2026-01-13
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_804_200)),  // 2026-01-19
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_063_400)),  // 2026-01-22
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_149_800)),  // 2026-01-23
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_236_200)),  // 2026-01-24
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_322_600)),  // 2026-01-25
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_754_600)),  // 2026-01-30
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_186_600)),  // 2026-02-04
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_273_000)),  // 2026-02-05
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_359_400)),  // 2026-02-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_618_600)),  // 2026-02-09
      ]
    ),
    showBorder: false,
    isPresented: .constant(true)
  )
  .environment(AppState.shared)
}
