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
  
  static var sampleData: [TestModel] = [
    TestModel(labelString: "1", bgColor: .systemYellow),
    TestModel(labelString: "2", bgColor: .systemCyan),
    TestModel(labelString: "3", bgColor: .tintColor)
  ]
}
