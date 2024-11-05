//
//  GoalModalViewController.swift
//  OneThing
//
//  Created by ch on 11/5/24.
//

import UIKit

class GoalModalViewController: UIViewController {
  
  var textField: UITextField = {
    var textField = UITextField()
    textField.placeholder = "목표를 입력하세요."
    textField.textColor = .white
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    textField.clearButtonMode = .always
    textField.clearsOnBeginEditing = false
    textField.returnKeyType = .done
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .darkGray
    return textField
  }()
  
  var goal: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.delegate = self
    
    textField.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(textField)
    NSLayoutConstraint.activate([
      textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      textField.widthAnchor.constraint(equalToConstant: 200),
      textField.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
}

extension GoalModalViewController: UITextFieldDelegate {
  
}
