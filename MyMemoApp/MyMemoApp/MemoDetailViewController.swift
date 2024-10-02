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
  
  lazy var menuItems: [UIAction] = MenuItems.detailMenuItems
  
  lazy var menu: UIMenu = UIMenu(title: "", options: [], children: menuItems)
  
  var isBackgroundBlack: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.text = memo?.content ?? ""
    
    let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareMemo))
    
    let detailOptionButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
    
    self.setMenuItems()
    
    detailOptionButton.menu = menu
    
    navigationItem.rightBarButtonItems = [detailOptionButton, shareButton]
  }
  
  @objc func shareMemo() {
    guard let memoText = self.textView.text else { return }
    
    let activityVC = UIActivityViewController(activityItems: [memoText], applicationActivities: nil)
    present(activityVC, animated: true, completion: nil)
  }
  
  func setMenuItems() {
    
    
    let backgroundActionTitle: String
    let backgroundActionImage: UIImage?
    
    if self.textView.backgroundColor == .black {
      backgroundActionTitle = "밝은 배경 사용"
      backgroundActionImage = UIImage(systemName: "circle.lefthalf.filled")
    } else {
      backgroundActionTitle = "어두운 배경 사용"
      backgroundActionImage = UIImage(systemName: "circle.righthalf.filled")
    }
    
    // 배경 색 변경 액션
    let backgroundAction = UIAction(title: backgroundActionTitle, image: backgroundActionImage) { [weak self] _ in
      guard let self = self else { return }
      if self.textView.backgroundColor == .black {
        self.textView.backgroundColor = .white
        self.textView.superview?.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.textView.textColor = .black
      } else {
        self.textView.backgroundColor = .black
        self.textView.superview?.backgroundColor = .black
        self.navigationController?.navigationBar.backgroundColor = .black
        self.textView.textColor = .white
      }
      self.setMenuItems()
    }
    
    menuItems[4] = backgroundAction
    
    menuItems[5] = UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { [weak self] _ in
      if let self = self {
        self.textView.text = ""
        self.memo?.content = ""
        self.navigationController?.popViewController(animated: true)
        return
      }
    })
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    if self.textView.text == "" {
      if memo != nil {
        memo!.content = self.textView.text
      }
    }
    
    self.navigationController?.navigationBar.backgroundColor = .black

    afterUnload(memo, self.textView.text)
  }
}
