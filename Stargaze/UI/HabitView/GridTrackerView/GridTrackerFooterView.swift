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
  @Environment(AppState.self) private var appState
  @State var daysRemaining: Int = 365

  var disablePreviousChevron: Bool {
    appState.selectedYear <= 2010
  }

  var disableNextChevron: Bool {
    appState.selectedYear > appState.currentYear + 5
  }

  var body: some View {
    HStack {
      HStack {
        Button("Previous Year", systemImage: "chevron.left") {
          onPreviousChevron()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .small,
            buttonDir: .leading,
            isDisabled: disablePreviousChevron
          )
        )
        .border(showBorder ? .green : .clear)
        .disabled(disablePreviousChevron)

        Text("\(appState.selectedYear.description)")
          .SGMono()
          .foregroundStyle(.secondary)
          .animation(.smooth(duration: 0.25), value: appState.selectedYear)

        Button("Next Year", systemImage: "chevron.right") {
          onNextChevron()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .small,
            buttonDir: .trailing,
            isDisabled: disableNextChevron
          )
        )
        .border(showBorder ? .green : .clear)
        .disabled(disableNextChevron)
      }
      Spacer()
      Text("\(daysRemaining) days left")
        .SGMono()
        .foregroundStyle(.secondary)
        .animation(.smooth(duration: 0.5), value: daysRemaining)
    }
    .frame(maxWidth: .infinity)
    .border(showBorder ? .green : .clear)
    .border(showBorder ? .purple : .clear)
    .onAppear {
      getDaysRemaining()
    }
    .onChange(of: appState.selectedYear) {
      getDaysRemaining()
    }
  }

  func onPreviousChevron() {
    appState.selectedYear -= 1
    if appState.selectedYear != appState.currentYear {
      appState.selectedDate = Calendar.current
        .date(
          from: DateComponents(
            year: appState.selectedYear,
            month: 1,
            day: 1
          )
        )!
    } else {
      appState.selectedDate = appState.currentDate
    }
  }

  func onNextChevron() {
    appState.selectedYear += 1
    if appState.selectedYear != appState.currentYear {
      appState.selectedDate = Calendar.current
        .date(
          from: DateComponents(
            year: appState.selectedYear,
            month: 1,
            day: 1
          )
        )!
    } else {
      appState.selectedDate = appState.currentDate
    }
  }

  func getDaysRemaining() {
    let daysInSelectedYear = appState.calculateDaysInSelectedYear()
    if appState.selectedYear == appState.currentYear {
      daysRemaining = daysInSelectedYear - appState.currentDate.dayOfYear
    } else {
      daysRemaining = daysInSelectedYear
    }
  }

}

#Preview {
  GridTrackerFooterView(showBorder: true)
    .environment(AppState.shared)
}
