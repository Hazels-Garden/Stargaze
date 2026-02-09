//
//  FooterView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct FooterView: View {

  @State private var isOn = false
  let color: [String: Double]
  let showBorder: Bool
  @Environment(AppState.self) private var appState
  @State var daysRemaining: Int = 365

  var body: some View {
    VStack(spacing: 10) {
      HStack {
        
        
        Button("Previous Day", systemImage: "chevron.left") {
          appState.selectedDate.toPreviousDay()
        }
        .buttonStyle(ChevronButton(buttonType: .large, buttonDir: .leading))

        
        Toggle(isOn: $isOn) {
          ToggleTextView(text: appState.formattedDateFromSelectedDate())
            .animation(.smooth(duration: 0.25), value: appState.selectedDate)
        }
        .toggleStyle(ActionToggle(color: color))
        .border(showBorder ? .purple : .clear)
        
        
        Button("Next Day", systemImage: "chevron.right") {
          appState.selectedDate.toNextDay()
        }
        .buttonStyle(ChevronButton(buttonType: .large, buttonDir: .trailing))
        
        
      }
      // Padding between grid view and footer
      .padding(.top, 40)
      
      Text("Streak: 3 • Total: 10")
        .SGLarge()
        .fontWidth(.compressed)
        .foregroundStyle(.secondary)
        .border(showBorder ? .purple : .clear)
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .border(showBorder ? .purple : .clear)
  }
}

#Preview {
  FooterView(color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1], showBorder: false)
    .environment(AppState.shared)
}
