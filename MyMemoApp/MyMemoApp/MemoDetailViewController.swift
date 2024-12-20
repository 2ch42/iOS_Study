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

  lazy var menuItems: [UIMenuElement] = MenuItems.detailMenuItems

  lazy var menu: UIMenu = UIMenu(title: "", options: [], children: menuItems)

  var isBackgroundBlack: Bool = false

  var searchBar = UISearchBar()

  var prevButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
    button.tintColor = .white
    return button
  }()

  var nextButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    button.tintColor = .white
    return button
  }()

  var completeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("완료", for: .normal)
    button.titleLabel?.numberOfLines = 1
    button.titleLabel?.font.withSize(3)
    button.tintColor = .white
    return button
  }()

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
    
    menuItems[0] = UIAction(title: "메모에서 찾기", image: UIImage(systemName: "magnifyingglass"), handler: { [weak self] UIAction in

      guard let self = self else { return }

      searchBar.isHidden = false
      searchBar.delegate = self

      self.view.addSubview(searchBar)
      self.view.addSubview(prevButton)
      self.view.addSubview(nextButton)
      self.view.addSubview(completeButton)

      searchBar.translatesAutoresizingMaskIntoConstraints = false
      self.textView.isFindInteractionEnabled = false

      NSLayoutConstraint.activate([
        nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        nextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        nextButton.heightAnchor.constraint(equalToConstant: 60),
        nextButton.widthAnchor.constraint(equalToConstant: 35),
        prevButton.heightAnchor.constraint(equalTo: nextButton.heightAnchor),
        prevButton.widthAnchor.constraint(equalTo: nextButton.widthAnchor),
        prevButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        prevButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor),
        searchBar.trailingAnchor.constraint(equalTo: self.prevButton.leadingAnchor),
        searchBar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        searchBar.heightAnchor.constraint(equalToConstant: 60),
        searchBar.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor),
        completeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        completeButton.heightAnchor.constraint(equalTo: nextButton.heightAnchor),
        completeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        completeButton.widthAnchor.constraint(equalToConstant: 50)
      ])

      searchBar.becomeFirstResponder()
    })
    
    menuItems[2] = UIAction(title: "줄 및 격자", image: UIImage(systemName: "rectangle.split.3x3"), handler: { [weak self] _ in
      
      guard let self = self else {
        return
      }

      let storyboard = UIStoryboard(name: "LineGridModal", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "LineGridViewController")
      vc.modalPresentationStyle = .popover
      self.present(vc, animated: true)
      return
    })

    let subAction1 = UIAction(title: "모두 작게 설정", handler: { UIAction in
      return
    })

    let subAction2 = UIAction(title: "모두 작게 설정", handler: { UIAction in
      return
    })
    
    menuItems[3] = UIMenu(title: "첨부 파일 보기", image: UIImage(systemName: "rectangle.3.group"), children: [subAction1, subAction2])
    
    let backgroundActionTitle: String
    let backgroundActionImage: UIImage?

    if self.textView.backgroundColor == .black {
      backgroundActionTitle = "밝은 배경 사용"
      backgroundActionImage = UIImage(systemName: "circle.lefthalf.filled")
    } else {
      backgroundActionTitle = "어두운 배경 사용"
      backgroundActionImage = UIImage(systemName: "circle.righthalf.filled")
    }

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

extension MemoDetailViewController: UISearchBarDelegate {

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.text = ""
    searchBar.isHidden = true
    self.textView.isFindInteractionEnabled = false
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.text = ""
  }
}
