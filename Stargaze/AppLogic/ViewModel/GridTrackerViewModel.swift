//
//  GridTrackerself.swift
//  Stargaze
//
//  Created by Hazel Nishad on 6/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftUI

@Observable
final class GridTrackerViewModel {
  var appState = AppState.shared
  var hasDataBeenSet: Bool
  var starPointsData:
    [(cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool)]
  var starCGPosMap: [Point: CGPoint]
  var tappedStarPoint: Point?

  var habit: Habit
  var checkedDaysSet: Set<Int>
  var checkedDaysSetByYear: [Int: Set<Int>]

  let horizontalPadding: CGFloat
  let verticalPadding: CGFloat
  let canvasHeight: CGFloat

  let starAngles = (0...366).map { _ in Double.random(in: 0...90) }
  var starGridPoints: [(x: Double, y: Double)] = []

  let nRows = 21
  let nCols = 18
  let starSize = 8.0
  var frame: CGRect {
    CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: CGSize(width: starSize, height: starSize)
    )
  }

  var canvasOrigin: CGPoint {
    CGPoint(x: horizontalPadding, y: verticalPadding)
  }

  var stride: (x: Double, y: Double)

  init(
    hasDataBeenSet: Bool = false,
    starPointsData: [(
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    )] = [],
    starCGPosMap: [Point: CGPoint] = [:],
    tappedStarPoint: Point? = nil,
    habit: Habit = Habit(),
    checkedDaysSet: Set<Int> = Set(),
    checkedDaysSetByYear: [Int: Set<Int>] = [:],
    horizontalPadding: CGFloat = 24,
    verticalPadding: CGFloat = 16,
    canvasHeight: CGFloat = 420,
    stride: (x: Double, y: Double) = (0, 0)
  ) {
    self.hasDataBeenSet = hasDataBeenSet
    self.starPointsData = starPointsData
    self.starCGPosMap = starCGPosMap
    self.tappedStarPoint = tappedStarPoint
    self.habit = habit
    self.checkedDaysSet = checkedDaysSet
    self.checkedDaysSetByYear = checkedDaysSetByYear
    self.horizontalPadding = horizontalPadding
    self.verticalPadding = verticalPadding
    self.canvasHeight = canvasHeight
    self.stride = stride
  }

  func initializeCanvas() {
    self.hasDataBeenSet = true
    self.getCheckedDaysSetByYear()
  }

  func initializeStars(size: CGSize) {
    self.starPointsData.removeAll()
    self.stride = self.calculateStarGridPoint(size: size, row: 1, col: 1)

    for i in 0..<nRows {
      for j in 0..<nCols {
        let currentStarNum = getStarNum(from: Point(r: i, c: j))
        guard
          currentStarNum
            <= appState.calculateDaysInSelectedYear()
        else { return }

        let starPos = self.calculateStarGridPoint(size: size, row: i, col: j)
        starGridPoints.append(starPos)
        self.saveStarPointsData(
          for: starPos,
          row: i,
          col: j,
          isChecked: isCheckedDayChecked(for: currentStarNum)
        )
      }
    }
  }

  // Reuse data
  func reinitializeStars(size: CGSize) {
    self.starPointsData.removeAll()
    for i in 0..<nRows {
      for j in 0..<nCols {
        let currentStarNum = getStarNum(from: Point(r: i, c: j))
        guard
          currentStarNum
            <= appState.calculateDaysInSelectedYear()
        else { return }
        let starPos = starGridPoints[currentStarNum - 1]
        self.saveStarPointsData(
          for: starPos,
          row: i,
          col: j,
          isChecked: isCheckedDayChecked(for: currentStarNum)
        )
      }
    }
  }

  func getCheckedDaysSetByYear() {
    self.checkedDaysSetByYear = [:]
    for checkedDay in self.habit.checkedDays {
      let yearComponent = Calendar.current.dateComponents(
        [.year],
        from: checkedDay.date
      )
      let dayOfYear = checkedDay.date.dayOfYear
      if self.checkedDaysSetByYear[yearComponent.year!] == nil {
        self.checkedDaysSetByYear[yearComponent.year!] = Set()
      }
      self.checkedDaysSetByYear[yearComponent.year!]?.insert(dayOfYear)
    }
  }

  func isCheckedDayChecked(for starNum: Int) -> Bool {
    var isChecked = false
    if let checkedDaysSetForSelectedYear = self.checkedDaysSetByYear[
      appState.selectedYear
    ] {
      isChecked = checkedDaysSetForSelectedYear.contains(starNum)
    }
    return isChecked
  }

  func saveStarPointsData(
    for starPos: (x: Double, y: Double),
    row: Int,
    col: Int,
    isChecked: Bool
  ) {
    // Saving the star points coords into a list
    let starCGPoint = CGPoint(
      x: starPos.x + (starSize / 2),
      y: starPos.y + (starSize / 2)
    )
    let starPoint = Point(r: row, c: col)
    self.starPointsData.append(
      (
        cgPoint: starCGPoint,
        intPoint: starPoint,
        angle: self.starAngles[self.getStarNum(from: starPoint) - 1],
        isChecked: isChecked
      )
    )
    self.starCGPosMap[starPoint] = starCGPoint
  }

  func calculateStarGridPoint(
    size: CGSize,
    row: Int,
    col: Int
  ) -> (x: Double, y: Double) {
    let canvasWidth = size.width - (2 * horizontalPadding)

    return (
      x:
        canvasOrigin.x
        + (Double(col) * ((canvasWidth - starSize) / Double(nCols - 1))),
      y:
        canvasOrigin.y
        + (Double(row) * ((canvasHeight - starSize) / Double(nRows - 1)))
    )
  }

  func getStarNum(from point: Point) -> Int {
    return (point.r * nCols + (point.c + 1))
  }

  func handleDragGesture(value: DragGesture.Value) -> (
    dist: Double,
    point: Point
  ) {
    var closestStarPoint = (
      dist: Double.infinity,
      point: Point(r: 0, c: 0)
    )

    let originAdjustedPos = (
      x: value.location.x - self.canvasOrigin.x,
      y: value.location.y - self.canvasOrigin.y
    )

    let closestStarY =
      round(
        (originAdjustedPos.y - (self.starSize / 2))
          / (self.stride.y - self.canvasOrigin.y)
      )
    let closestStarX =
      round(
        (originAdjustedPos.x - (self.starSize / 2))
          / (self.stride.x - self.canvasOrigin.x)
      )

    closestStarPoint.point = Point(
      r: Int(closestStarY).clamped(to: 0...self.nRows - 1),
      c: Int(closestStarX).clamped(to: 0...self.nCols - 1)
    )

    let starCGPoint =
      self.starCGPosMap[closestStarPoint.point]
      ?? CGPoint(
        x: 0,
        y: 0
      )

    closestStarPoint.dist =
      pow((starCGPoint.x - value.location.x), 2)
      + pow((starCGPoint.y - value.location.y), 2)

    // Set selected date to tapped point (clamped to numDaysInYear)
    let daysInSelectedYear = appState.calculateDaysInSelectedYear()
    let tappedStarInt = getStarNum(from: closestStarPoint.point)
      .clamped(
        to: 1...daysInSelectedYear
      )
    if tappedStarInt == appState.currentDate.dayOfYear {
      // Footer reset view needs selected date to be eq. to current date to work
      appState.selectedDate = appState.currentDate
    } else {
      if let newSelectedDate = appState.calculateDateFromSelectedDayOfYear(
        dayOfYear: tappedStarInt
      ) {
        appState.selectedDate = newSelectedDate
      }
    }

    return closestStarPoint
  }

  func handleDragGestureEnd(value: DragGesture.Value? = nil) {
    if let dragEndValue = value {
      let closestStarPoint = self.handleDragGesture(value: dragEndValue)
      guard
        self.getStarNum(from: closestStarPoint.point)
          == appState.currentDate.dayOfYear
      else { return }
    }
    self.resetTappedStarPoint()
  }

  @objc func resetTappedStarPoint() {
    self.tappedStarPoint = nil
  }
}
