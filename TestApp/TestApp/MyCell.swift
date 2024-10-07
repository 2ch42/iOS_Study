//
//  MyCell.swift
//  TestApp
//
//  Created by ch on 10/6/24.
//

import UIKit

class MyCell: UICollectionViewCell {
  static let reuseIdentifer = "MyCell"
  
  var myLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()
  
  var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(myLabel)
    self.contentView.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      self.myLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 10),
      self.myLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 10),
      self.myLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -10),
      self.imageView.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -10),
      self.imageView.topAnchor.constraint(greaterThanOrEqualTo: self.myLabel.bottomAnchor, constant: 10),
      self.imageView.leadingAnchor.constraint(equalTo: self.myLabel.leadingAnchor),
      self.imageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.myLabel.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(_ testModel: TestModel) {
    self.myLabel.text = testModel.labelString
    self.imageView.image = UIImage(systemName: testModel.imageString)
    self.backgroundColor = testModel.color
    self.contentView.backgroundColor = testModel.color
    print(self.frame.width, self.frame.height)
    print(self.contentView.frame.width, self.contentView.frame.height)
  }
}