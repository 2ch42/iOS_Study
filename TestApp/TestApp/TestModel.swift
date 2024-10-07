//
//  TestModel.swift
//  TestApp
//
//  Created by ch on 10/6/24.
//

import Foundation
import UIKit

struct TestModel {
  let imageString: String
  let labelString: String
  let color: UIColor
  
  static var sampleData: [TestModel] = [
    TestModel(imageString: "sun.max.fill", labelString: "sun.max.fill", color: .systemYellow),
    TestModel(imageString: "sunrise.fill", labelString: "sunrise.fill", color: .systemMint),
    TestModel(imageString: "moon.haze", labelString: "moon.haze", color: .systemCyan)
  ]
}
