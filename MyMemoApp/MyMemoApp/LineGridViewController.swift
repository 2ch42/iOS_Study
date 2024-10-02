//
//  LineGridViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 10/2/24.
//

import UIKit

class LineGridViewController: UIViewController {
  
  @IBOutlet weak var toolBar: UIToolbar!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    toolBar.tintColor = .white
    toolBar.isTranslucent = true
    
    let leftCancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(quitModalAction))
    leftCancelButton.tintColor = .systemYellow
    let centerTitle = UIBarButtonItem(title: "줄 및 격자", style: .done , target: self, action: nil)
    let whiteSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    toolBar.setItems([leftCancelButton, whiteSpace, centerTitle, whiteSpace, whiteSpace], animated: true)
  }
  
  @objc func quitModalAction() {
    self.viewWillDisappear(true)
  }
}
