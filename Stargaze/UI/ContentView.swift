//
//  ContentView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 10/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      HabitView()
      HabitView()
      HabitView()
      HabitView()
      HabitView()
      HabitView()
    }
    .ignoresSafeArea()
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
}

#Preview {
  ContentView()
}
