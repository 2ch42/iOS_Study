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


    override func awakeFromNib() {

        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ memo: Memo) {
        self.dateLabel.text = memo.date.formatted()
        self.descriptionLabel.text = memo.description
    }
}
