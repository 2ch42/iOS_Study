//
//  CollectionViewCell.swift
//  LoopCVApp
//
//  Created by ch on 10/8/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

  static var reuseIdentifier: String = "CollectionViewCell"

  private let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()

  func configure(_ testModel: TestModel) {
    self.backgroundColor = testModel.bgColor
    self.contentView.backgroundColor = testModel.bgColor
    self.label.text = testModel.labelString
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("cell coder is not implemented")
  }
}
