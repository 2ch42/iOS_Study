//
//  FocusTimer.swift
//  OneThing
//
//  Created by ch on 11/3/24.
//

import Foundation

struct FocusTimer {
  
  var timeSet: Int
  
  var year: String
  
  var month: String
  
  var day: String
  
  var success: Bool = false
  
  init(timeSet: Int) {

    self.timeSet = timeSet

    let date = Date()
    
    let yearFormatter = DateFormatter()
    let monthFormatter = DateFormatter()
    let dayFormatter = DateFormatter()

    yearFormatter.dateFormat = "yyyy"
    monthFormatter.dateFormat = "MM"
    dayFormatter.dateFormat = "dd"

    self.year = yearFormatter.string(from: date)
    self.month = monthFormatter.string(from: date)
    self.day = dayFormatter.string(from: date)
  }
}
