//
//  FocusViewController.swift
//  OneThing
//
//  Created by ch on 11/5/24.
//

import UIKit

class FocusViewController: UIViewController {
  
  var focusTimer: FocusTimer? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let vc = GoalModalViewController()
    
    self.present(vc, animated: true)    
  }
}
