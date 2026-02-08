//
//  Extensions.swift
//  Stargaze
//
//  Created by Hazel Nishad on 11/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

// View+Padding
extension View {
  func padding(horizontal: CGFloat, vertical: CGFloat) -> some View {
    self
      .padding(.horizontal, horizontal)
      .padding(.vertical, vertical)
  }

  func padding(top: CGFloat, bottom: CGFloat) -> some View {
    self
      .padding(.top, top)
      .padding(.bottom, bottom)
  }

  func padding(leading: CGFloat, trailing: CGFloat) -> some View {
    self
      .padding(.leading, leading)
      .padding(.trailing, trailing)
  }

}

// Collection+IsNotEmpty
extension Collection {
  var isNotEmpty: Bool {
    !self.isEmpty
  }
}

// Source - https://stackoverflow.com/a/56894458
// Posted by Tolgahan Arıkan, modified by community. See post 'Timeline' for change history
// Retrieved 2026-01-11, License - CC BY-SA 4.0
// Color+Hex
extension Color {
  init(hex: UInt, alpha: Double = 1) {
    self.init(
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: alpha
    )
  }
}

// Source - https://stackoverflow.com/a/42623106
// Posted by Adam Smaka
// Retrieved 2026-02-07, License - CC BY-SA 3.0
// Date+DayOfYear
extension Date {
  var dayOfYear: Int {
    return Calendar.current.ordinality(of: .day, in: .year, for: self)!
  }
}

// Source - https://stackoverflow.com/a/40868784
// Posted by Ondrej Stocek, modified by community. See post 'Timeline' for change history
// Retrieved 2026-02-08, License - CC BY-SA 4.0
// Comparable+Clamped
extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}



// Text+Styles
extension Text {
  func SGTitle() -> some View {
    self
      .font(.system(size: 24))
      .fontWeight(.bold)
      .multilineTextAlignment(.center)
  }

  func SGXLarge() -> some View {
    self
      .font(.system(size: 17))
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
  }
  
  func SGLarge() -> some View {
    self
      .font(.system(size: 15))
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
  }

  func SGNormal() -> some View {
    self
      .font(.system(size: 13).leading(.tight))
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
  }

  func SGSmall() -> some View {
    self
      .font(.system(size: 12))
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
  }

  func SGMono() -> some View {
    self
      .font(.system(size: 13))
      .fontWeight(.semibold)
      .fontDesign(.monospaced)
      .multilineTextAlignment(.center)
  }
}
