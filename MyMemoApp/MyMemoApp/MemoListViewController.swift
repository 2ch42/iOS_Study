//
//  ViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/6/24.
//

import UIKit
import CoreData

class MemoListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var toolBar: UIToolbar!
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var persistentContainer: NSPersistentContainer? {
    (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  }
  
  @Published var list: [MemoDummies] = []
  
  @Published var filteredList: [MemoDummies] = []
  
  @Published var isFiltered: Bool = false
  
  lazy var menuItems: [UIMenuElement] = MenuItems.listMenuItems
  
  lazy var menu: UIMenu = UIMenu(title: "", options: [], children: menuItems)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    list = readData()
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    toolBar.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.dataSource = self
    tableView.delegate = self
    
    searchBar.delegate = self
    
    
    navigationController?.navigationBar.tintColor = .systemYellow
    navigationController?.navigationBar.backgroundColor = .black
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = .black
    
    let listOptionButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
    
    self.setMenuItems()
    
    listOptionButton.menu = menu
    navigationItem.rightBarButtonItem = listOptionButton
    
    setToolbar(true)
  }
  
  @objc func addNewItem() {
    
    let storyboard = UIStoryboard(name: "MemoDetail", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "MemoDetailViewController") as! MemoDetailViewController
    navigationController?.pushViewController(vc, animated: true)
    vc.afterUnload = { [unowned self] memo, content in
      if content == "" {
        return
      }
      self.createData(content)
      self.list = readData()
      self.tableView.insertRows(at: [IndexPath(row: list.count - 1, section: 0)], with: .none)
      //            self.tableView.reloadRows(at: [IndexPath(row: list.count, section: 0)], with: .none)
      if let memoCountsText = self.toolBar.items?.first(where: { $0.title?.contains("개의 메모") == true }) {
        memoCountsText.title = "\(self.list.count)개의 메모"
      }
      self.isFiltered = false
      self.tableView.reloadData()
    }
  }

  func setToolbar(_ isDefault: Bool) {
    if isDefault {
      let newMemoButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(addNewItem))
      
      let toolBarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
      
      let memoCountsText = UIBarButtonItem(title: "\(list.count)개의 메모", style: .plain, target: self, action: nil)
      
      memoCountsText.tintColor = .white
      
      toolBar.tintColor = .systemYellow
      toolBar.isTranslucent = false
      toolBar.barTintColor = .black
      toolBar.backgroundColor = .black
      toolBar.setItems([toolBarSpace, memoCountsText, toolBarSpace, newMemoButton], animated: true)
    }
  }
  
  func setMenuItems() {
    menuItems[0] = UIAction(title: "메모 선택", image: UIImage(systemName: "checkmark.circle"), handler: { [weak self] UIAction in
      
      guard let self = self else { return }
      
      self.tableView.allowsMultipleSelection = true
      
      // 관련 작업들 수행-> delegate에서 다 처리해줘야할지는 좀 더 알아봐야함.
      
      return
    })
  }
  
  func createData(_ content: String) {
    guard let context = self.persistentContainer?.viewContext else { return }
    
    let newMemo = MemoDummies(context: context)
    
    newMemo.id = UUID()
    newMemo.createDate = Date()
    newMemo.updateDate = Date()
    newMemo.content = content
    
    try? context.save()
  }
  
  func readData() -> [MemoDummies] {
    
    guard let context = self.persistentContainer?.viewContext else { return [] }
    
    let request = MemoDummies.fetchRequest()
    
    guard let memoList = try? context.fetch(request) else { return [] }
    return memoList.sorted()
  }
  
  func updateData(_ memo: MemoDummies, _ content: String) {
    
    guard let context = self.persistentContainer?.viewContext else { return }
    
    let request = MemoDummies.fetchRequest()
    
    guard let memos = try? context.fetch(request) else { return }
    
    let willUpdateMemo = memos.filter({ $0.id == memo.id })
    
    willUpdateMemo[0].updateDate = Date()
    willUpdateMemo[0].content = content
    
    try? context.save()
  }
  
  func deleteData(_ memo: MemoDummies) {
    
    guard let context = self.persistentContainer?.viewContext else { return }
    
    let willDeleteMemo = list.filter({ $0.id == memo.id })
    
    context.delete(willDeleteMemo[0])
    
    try? context.save()
  }
}

extension MemoListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoCell else {
      print("Failed casting to MemoCell")
      return UITableViewCell()
    }

    isFiltered ? cell.configure(filteredList[indexPath.item]) : cell.configure(list[indexPath.item])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isFiltered ? filteredList.count : list.count
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let delButton = UIContextualAction(style: .destructive, title: "삭제") { [unowned self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
      if (self.isFiltered) {
        deleteData(filteredList[indexPath.item])
        list = readData()
        guard let text = self.searchBar.text else {
          return
        }
        filteredList = list.filter { $0.content?.localizedCaseInsensitiveContains(text) ?? true
        }
      } else {
        deleteData(list[indexPath.item])
        list = readData()
      }
      tableView.deleteRows(at: [indexPath], with: .fade)
      if let memoCountsText = toolBar.items?.first(where: { $0.title?.contains("개의 메모") == true }) {
        memoCountsText.title = "\(list.count)개의 메모"
      }
    }
    return UISwipeActionsConfiguration(actions: [delButton])
  }
}

extension MemoListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: "MemoDetail", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "MemoDetailViewController") as! MemoDetailViewController
    navigationController?.pushViewController(vc, animated: true)
    vc.memo = self.isFiltered ? filteredList[indexPath.item] : list[indexPath.item]
    vc.afterUnload = { [unowned self] memo, content in
      if memo!.content == "" {
        deleteData(list[indexPath.item])
        self.list = readData()
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        if let memoCountsText = self.toolBar.items?.first(where: { $0.title?.contains("개의 메모") == true }) {
          memoCountsText.title = "\(list.count)개의 메모"
        }
      } else {
        if memo?.content != content {
          updateData(memo!, content)
        }
        list = readData()
        self.tableView.reloadData()
      }
      self.isFiltered = false
      self.tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
    // button 보여지게
    return true
  }

  func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
    list = readData()

    setToolbar(true)

    tableView.reloadData()
  }
}

extension MemoListViewController: UISearchBarDelegate {
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
    self.isFiltered = false
    self.tableView.reloadData()
    self.toolBar.isHidden = false
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.filteredList = []
    searchBar.showsCancelButton = true
    self.isFiltered = true
    self.tableView.reloadData()
    self.toolBar.isHidden = true
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    self.tableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let text = searchText.lowercased()
    self.filteredList = self.list.filter { $0.content?.localizedCaseInsensitiveContains(text) ?? true
    }
    self.tableView.reloadData()
  }
  
  //  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  //    self.list = self.list.filter { MemoDummies in
  //      return MemoDummies.content?.contains(searchText) != nil ? true : false
  //    }
  //  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text?.lowercased() else { return }
    self.filteredList = self.list.filter { $0.content?.localizedCaseInsensitiveContains(text) ?? true
    }
    self.tableView.reloadData()
  }
}
