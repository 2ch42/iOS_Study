//
//  AnalyzeViewController.swift
//  OneThing
//
//  Created by 이창현 on 10/26/24.
//

import UIKit

class AnalyzeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .black

    let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
    ]
    // navigation setting
    self.navigationItem.title = "분석"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
  }
}
