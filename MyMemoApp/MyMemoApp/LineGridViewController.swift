//
//  LineGridViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 10/2/24.
//

import UIKit

class LineGridViewController: UIViewController {
  
  @IBOutlet weak var toolBar: UIToolbar!

  @IBOutlet weak var innerView: UIView!
  
  @IBOutlet weak var helpLabel: UILabel!

  var imgViews: [UIImageView] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    toolBar.tintColor = .white
    toolBar.isTranslucent = true
    
    let leftCancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(quitModalAction))
    leftCancelButton.tintColor = .systemYellow
    let centerTitle = UIBarButtonItem(title: "줄 및 격자", style: .done , target: self, action: nil)
    let whiteSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    toolBar.setItems([leftCancelButton, whiteSpace, centerTitle, whiteSpace, whiteSpace], animated: true)
    
    self.innerView.translatesAutoresizingMaskIntoConstraints = false
    
    for i in 0...6 {
      let imgView = UIImageView(image: UIImage(named: "lineGridImg\(i + 1)"))
      imgView.translatesAutoresizingMaskIntoConstraints = false
      imgViews.append(imgView)
      self.innerView.addSubview(imgView)
    }

    imgViews[0].topAnchor.constraint(equalTo: self.helpLabel.bottomAnchor, constant: 30).isActive = true
    imgViews[0].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 10).isActive = true
    imgViews[1].topAnchor.constraint(equalTo: imgViews[0].bottomAnchor, constant: 20).isActive = true
    imgViews[1].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 10).isActive = true
    imgViews[2].topAnchor.constraint(equalTo: imgViews[1].bottomAnchor, constant: 20).isActive = true
    imgViews[2].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 10).isActive = true
    imgViews[3].topAnchor.constraint(equalTo: imgViews[2].bottomAnchor, constant: 20).isActive = true
    imgViews[3].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 10).isActive = true
    imgViews[3].bottomAnchor.constraint(greaterThanOrEqualTo: self.innerView.bottomAnchor, constant: -30).isActive = true
    //
    imgViews[4].centerYAnchor.constraint(equalTo: imgViews[1].centerYAnchor).isActive = true
    imgViews[4].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -10).isActive = true
    imgViews[5].centerYAnchor.constraint(equalTo: imgViews[2].centerYAnchor).isActive = true
    imgViews[5].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -10).isActive = true
    imgViews[6].centerYAnchor.constraint(equalTo: imgViews[3].centerYAnchor).isActive = true
    imgViews[6].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -10).isActive = true
    
    for i in 0...6 {
      imgViews[i].widthAnchor.constraint(equalToConstant: 150).isActive = true
      imgViews[i].heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
  }
  
  @objc func quitModalAction() {
    dismiss(animated: true)
  }
}
