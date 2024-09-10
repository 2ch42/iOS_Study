//
//  MemoDetailViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/8/24.
//

import UIKit

class MemoDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var memo: Memo = Memo(date: Date(), description: "Temp")
    var memoList: [Memo] = []
    var deleteEmpty: ((Memo) -> ()) = { memo in }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = memo.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        if (memo.description != textView.text) {
            memo.description = textView.text
            memo.date = Date()
        }

        if (memo.description == "") {
            deleteEmpty(memo)
        }
    }
}
