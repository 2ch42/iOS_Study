//
//  MemoDetailViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/8/24.
//

import UIKit
import CoreData

class MemoDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var memo: MemoDummies? = nil
    
    var afterUnload: (MemoDummies?, String) -> () = { memo, content in }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = memo?.content ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        if self.textView.text == "" {
            if memo != nil {
                memo!.content = self.textView.text
            }
        }
        
        afterUnload(memo, self.textView.text)
    }
}
