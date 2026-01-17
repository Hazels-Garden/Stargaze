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
  let showBorder: Bool
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Button("Previous Day", systemImage: "chevron.left") {

        }
        .labelStyle(.iconOnly)
        .font(.system(size: 24))
        .fontWeight(.bold)
        .foregroundStyle(.quaternary)

        Toggle(isOn: $isOn) {
          ToggleTextView(text: "Saturday, 21/01")
        }
        .toggleStyle(.button)
        .tint(.clear)
        .padding(.vertical, 12)
        .background(
          isOn
            ? Color(hex: 0xD78725, alpha: 1) : Color(hex: 0xD78725, alpha: 0.2)
        )
        .foregroundStyle(isOn ? .primary : .secondary)
        .clipShape(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .border(showBorder ? .purple : .clear)
        Button("Next Day", systemImage: "chevron.right") {

        }
        .labelStyle(.iconOnly)
        .font(.system(size: 24))
        .fontWeight(.bold)
        .foregroundStyle(.quaternary)
      }
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
  FooterView(showBorder: false)
}
