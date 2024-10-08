//
//  TestModel.swift
//  LoopCVApp
//
//  Created by ch on 10/8/24.
//

import Foundation
import UIKit

struct TestModel: Hashable {
  var labelString: String
  var bgColor: UIColor
  var id: UUID
  
  static var sampleData: [TestModel] = [
    TestModel(labelString: "1", bgColor: .systemYellow, id: UUID()),
    TestModel(labelString: "2", bgColor: .systemCyan, id: UUID()),
    TestModel(labelString: "3", bgColor: .tintColor, id: UUID())
  ]
}
