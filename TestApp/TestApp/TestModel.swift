//
//  TestModel.swift
//  TestApp
//
//  Created by ch on 10/6/24.
//

import Foundation
import UIKit

struct TestModel: Hashable {
  let imageString: String
  let labelString: String
  let color: UIColor
  var id: UUID
  
  static var sampleData: [TestModel] = [
    TestModel(imageString: "sun.max.fill", labelString: "page1", color: .systemYellow, id: UUID()),
    TestModel(imageString: "sunrise.fill", labelString: "page2", color: .systemMint, id: UUID()),
    TestModel(imageString: "moon.haze", labelString: "page3", color: .systemCyan, id: UUID())
  ]
}
