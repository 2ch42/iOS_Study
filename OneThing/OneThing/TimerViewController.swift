//
//  ViewController.swift
//  OneThing
//
//  Created by 이창현 on 10/26/24.
//

import UIKit

class TimerViewController: UIViewController {
  
  let pickerView = UIPickerView()
  
  let label: UILabel = {
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
    self.view.addSubview(label)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      pickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      pickerView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100),
      pickerView.heightAnchor.constraint(equalToConstant: 300),
      label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      label.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100),
      label.heightAnchor.constraint(equalToConstant: 35)
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
}
