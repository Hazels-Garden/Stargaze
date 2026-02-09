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

  var body: some View {
    HStack {
      HStack {
        Button("Previous Year", systemImage: "chevron.left") {
          appState.selectedYear -= 1
        }
        .buttonStyle(ChevronButton(buttonType: .small, buttonDir: .leading))
        .border(showBorder ? .green : .clear)

        Text("\(appState.selectedYear.description)")
          .SGMono()
          .foregroundStyle(.secondary)
          .animation(.smooth(duration: 0.25), value: appState.selectedYear)

        Button("Next Year", systemImage: "chevron.right") {
          appState.selectedYear += 1
        }
        .buttonStyle(ChevronButton(buttonType: .small, buttonDir: .trailing))
        .border(showBorder ? .green : .clear)
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

  func getDaysRemaining() {
    appState.calculateDaysInSelectedYear()
    if appState.selectedYear == appState.currentYear {
      daysRemaining = appState.daysInSelectedYear - appState.currentDayOfYear
    } else {
      daysRemaining = appState.daysInSelectedYear
    }
  }

}

#Preview {
  GridTrackerFooterView(showBorder: true)
    .environment(AppState.shared)
}
