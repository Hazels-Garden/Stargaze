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

  //View+DetentSheet
  func detentSheet<Content: View>(
    isPresented: Binding<Bool>,
    selectedDetent: Binding<Detent.DetentEnum>,
    @ViewBuilder content: @escaping (Binding<Detent.DetentEnum>) -> Content
  ) -> some View {
    modifier(
      DetentSheetPresenter(
        isPresented: isPresented,
        sheetContent: content,
        selectedDetentEnum: selectedDetent,
      )
    )
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

  // Source - https://stackoverflow.com/a/78649412
  // Posted by Codelaby, modified by community. See post 'Timeline' for change history
  // Retrieved 2026-02-11, License - CC BY-SA 4.0
  //Color+Mix
  func mixed(with color: Color, by percentage: Double) -> Color {
    let clampedPercentage = min(max(percentage, 0), 1)

    let components1 = UIColor(self).cgColor.components!
    let components2 = UIColor(color).cgColor.components!

    let red =
      (1.0 - clampedPercentage) * components1[0] + clampedPercentage
      * components2[0]
    let green =
      (1.0 - clampedPercentage) * components1[1] + clampedPercentage
      * components2[1]
    let blue =
      (1.0 - clampedPercentage) * components1[2] + clampedPercentage
      * components2[2]
    let alpha =
      (1.0 - clampedPercentage) * components1[3] + clampedPercentage
      * components2[3]

    return Color(red: red, green: green, blue: blue, opacity: alpha)
  }
}

// Source - https://stackoverflow.com/a/42623106
// Posted by Adam Smaka
// Retrieved 2026-02-07, License - CC BY-SA 3.0
// Date+DayOfYear
nonisolated
  extension Date
{
  var dayOfYear: Int {
    let calendar = Calendar(identifier: .gregorian)
    return calendar.ordinality(of: .day, in: .year, for: self)!
  }

  // Source - https://stackoverflow.com/a/52704760
  // Posted by Adrian, modified by community. See post 'Timeline' for change history
  // Retrieved 2026-02-13, License - CC BY-SA 4.0
  // Modified to include now and h/m/s by Hazel (me).
  //Date+From (Components)
  static func from(
    year: Int? = nil,
    month: Int = 1,
    day: Int = 1,
    hour: Int = 12,
    minute: Int = 0,
    second: Int = 0,
    now: Bool = false
  ) -> Date? {
    let calendar = Calendar(identifier: .gregorian)
    if now {
      return
        calendar
        .date(
          bySettingHour: 12,
          minute: 0,
          second: 0,
          of: Date.now,
        )!
    }
    var dateComponents = DateComponents()
    dateComponents.year = year ?? calendar.component(.year, from: Date.now)
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.hour = hour
    dateComponents.minute = minute
    dateComponents.second = second
    return calendar.date(from: dateComponents) ?? nil
  }

  //Date+From (DateOnly)
  static func from(dateOnly: DateOnly) -> Date? {
    Date.from(year: dateOnly.year, month: dateOnly.month, day: dateOnly.day)
      ?? nil
  }

  // The below are written by me (Hazel)
  // Date+ToPreviousDay
  mutating func toPreviousDay() {
    let calendar = Calendar(identifier: .gregorian)
    self = calendar.date(byAdding: .day, value: -1, to: self)!
  }

  // Date+ToNextDay
  mutating func toNextDay() {
    let calendar = Calendar(identifier: .gregorian)
    self = calendar.date(byAdding: .day, value: 1, to: self)!
  }

  //Date+Get
  static func get(from date: Date, with components: Set<Calendar.Component>)
    -> DateComponents
  {
    let calendar = Calendar(identifier: .gregorian)
    return calendar.dateComponents(
      components,
      from: date
    )
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

  func SGXXLarge() -> some View {
    self
      .font(.system(size: 19))
      .fontWeight(.semibold)
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
