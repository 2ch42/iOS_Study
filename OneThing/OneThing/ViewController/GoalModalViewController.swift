//
//  GoalModalViewController.swift
//  OneThing
//
//  Created by ch on 11/5/24.
//

import UIKit

class GoalModalViewController: UIViewController {
  
  var setGoal: (String) -> () = { goal in }
  
  var startCountDown: () -> () = { }
  
  var stackView: UIStackView = {
    let view = UIStackView()
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.borderWidth = 1
    return view
  }()

  var label: UILabel = {
    var label = UILabel()
    label.backgroundColor = .systemBlue
    label.attributedText = NSAttributedString(string: "GOAL", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
  }()
  
  var textField: UITextField = {
    var textField = UITextField()
    textField.placeholder = "목표를 입력하세요."
    textField.textAlignment = .center
    textField.textColor = .white
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    textField.clearButtonMode = .always
    textField.clearsOnBeginEditing = false
    textField.returnKeyType = .done
    textField.borderStyle = .roundedRect
    textField.tintColor = .white
    textField.backgroundColor = .black
    textField.attributedPlaceholder = NSAttributedString(string: "목표를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    return textField
  }()
  
  var goal: String? = nil

  override func viewDidLoad() {
    super.viewDidLoad()

    textField.delegate = self

    textField.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(stackView)
    stackView.addSubview(label)
    stackView.addSubview(textField)
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      stackView.widthAnchor.constraint(equalToConstant: 250),
      stackView.heightAnchor.constraint(equalToConstant: 150),
      label.topAnchor.constraint(equalTo: stackView.topAnchor),
      label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      textField.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
      textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      label.heightAnchor.constraint(equalToConstant: 70),
      textField.topAnchor.constraint(equalTo: label.bottomAnchor)
    ])

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
    self.view.addGestureRecognizer(tapGesture)

  }
  
  override func viewDidDisappear(_ animated: Bool) {

    super.viewDidDisappear(animated)

    startCountDown()
  }

  @objc func handleTapOutside() {
      self.textField.endEditing(true)
  }
}

extension GoalModalViewController: UITextFieldDelegate {

  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()
    if let fieldText = textField.text {
      self.setGoal(fieldText)
      self.dismiss(animated: true)
    }
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
