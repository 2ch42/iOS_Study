////
////  Memo.swift
////  MyMemoApp
////
////  Created by 이창현 on 9/6/24.
////
//
import Foundation
import CoreData

extension MemoDummies: Comparable {
  public static func < (lhs: MemoDummies, rhs: MemoDummies) -> Bool {
    guard let lhsDate = lhs.updateDate else { fatalError("no update date")}
    guard let rhsDate = rhs.updateDate else { fatalError("no update date")}
    
    if lhsDate < rhsDate { return false } else { return true }
  }
}
