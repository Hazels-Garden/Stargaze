//
//  ToggleTextView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 11/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct ToggleTextView: View {
  
  let text: String
  
  var body: some View {
    Text(text)
      .fontWeight(.bold)
      .SGNormal()
      .fontWidth(.expanded)
      .frame(minWidth: 200)
  }
}


#Preview {
  ToggleTextView(text: "Friday, 21/01")
    .environment(AppState.shared)
}
