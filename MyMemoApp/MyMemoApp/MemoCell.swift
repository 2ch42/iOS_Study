//
//  MemoCell.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/6/24.
//

import UIKit

class MemoCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var edgeView: UIView!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    edgeView.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
  }
  
  func configure(_ memo: MemoDummies) {
    self.dateLabel.text = (memo.updateDate?.formatted()) ?? ""
    self.descriptionLabel.text = memo.content
  }
}
