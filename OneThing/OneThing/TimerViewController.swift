//
//  ViewController.swift
//  OneThing
//
//  Created by 이창현 on 10/26/24.
//

import UIKit

class TimerViewController: UIViewController {
  
  let pickerView = UIPickerView()
  
  let minuteLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .darkGray
    label.clipsToBounds = true
    label.isOpaque = false
    label.text = "분 동안 "
    label.textAlignment = .right
    label.textColor = .white
    label.layer.cornerRadius = 10
    label.numberOfLines = 1
    return label
  }()
  
  let startButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(updateTime), for: .touchUpInside)
    button.addTarget(self, action: #selector(updateBgColor), for: .touchDown)
    button.setTitle("시작", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 25
    return button
  }()
  
  @objc func updateTime() {
    self.chosenTime = self.selectedTime
    if let chosenTime = self.chosenTime { print("chosenTime: \(chosenTime)") }
    self.startButton.backgroundColor = .white
  }
  
  @objc func updateBgColor() {
    startButton.backgroundColor = .darkGray
  }
  
  var selectedTime: Int? = 5
  var chosenTime: Int? = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .black

    // navigation setting
    self.navigationItem.title = "타이머"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.largeTitleTextAttributes = [
      .foregroundColor: UIColor.white
    ]
    
    pickerView.delegate = self
    pickerView.dataSource = self
    
    pickerView.isOpaque = false
    
    
    // Auto Layout
    self.view.addSubview(pickerView)
    self.view.addSubview(minuteLabel)
    self.view.addSubview(startButton)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    minuteLabel.translatesAutoresizingMaskIntoConstraints = false
    startButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      pickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
      pickerView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100),
      pickerView.heightAnchor.constraint(equalToConstant: 300),
      minuteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      minuteLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
      minuteLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100),
      minuteLabel.heightAnchor.constraint(equalToConstant: 35),
      startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      startButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 80),
      startButton.widthAnchor.constraint(equalToConstant: 140),
      startButton.heightAnchor.constraint(equalToConstant: 50)
    ])
    self.view.bringSubviewToFront(pickerView)
  }
}

extension TimerViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 12
  }
}

extension TimerViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 50
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return pickerView.frame.width
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return NSAttributedString(string: "\(row * 5 + 5)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.selectedTime = row * 5 + 5
    if let selectedTime = self.selectedTime { print("selectedTime: \(selectedTime)")}
  }
}
