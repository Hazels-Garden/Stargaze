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
  var hasDataBeenSet: Bool
  var starPointsData:
    [(cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool)]
  var starCGPosMap: [Point: CGPoint]
  var tappedStarPoint: Point?

  var color: [String: Double]
  var checkedDays: [CheckedDays]
  var checkedDaysSet: Set<Int>

  let horizontalPadding: CGFloat
  let verticalPadding: CGFloat
  let canvasHeight: CGFloat

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
    color: [String: Double],
    checkedDays: [CheckedDays],
    checkedDaysSet: Set<Int> = Set(),
    horizontalPadding: CGFloat = 24,
    verticalPadding: CGFloat = 16,
    canvasHeight: CGFloat = 420,
    stride: (x: Double, y: Double) = (0, 0)
  ) {
    self.hasDataBeenSet = hasDataBeenSet
    self.starPointsData = starPointsData
    self.starCGPosMap = starCGPosMap
    self.tappedStarPoint = tappedStarPoint
    self.color = color
    self.checkedDays = checkedDays
    self.checkedDaysSet = checkedDaysSet
    self.horizontalPadding = horizontalPadding
    self.verticalPadding = verticalPadding
    self.canvasHeight = canvasHeight
    self.stride = stride
  }

  func initializeStars(size: CGSize) {
    self.stride = self.calculateStarGridPoint(size: size, row: 1, col: 1)

    for i in 0..<nRows {
      for j in 0..<nCols {
        let currentStarNum = i * nCols + (j + 1)
        guard currentStarNum <= 365 else { return }
        let isChecked = self.checkedDaysSet.contains(
          Int(currentStarNum)
        )
        let starPos = self.calculateStarGridPoint(size: size, row: i, col: j)
        self.saveStarPointsData(
          for: starPos,
          row: i,
          col: j,
          isChecked: isChecked
        )
      }
    }
  }

  func getCheckedDaysSet() {
    for checkedDay in self.checkedDays {
      let dayOfYear = checkedDay.date.dayOfYear
      self.checkedDaysSet.insert(dayOfYear)
    }
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
        angle: Double.random(in: 0...90),
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

    return closestStarPoint
  }
}
