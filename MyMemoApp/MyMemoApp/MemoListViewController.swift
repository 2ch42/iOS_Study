//
//  ViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/6/24.
//

import UIKit

class MemoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var toolBar: UIToolbar!

    var list: [Memo] = Memo.sampleList.sorted()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self

        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black

        let listOptionButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = listOptionButton
        
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
    
    @objc func addNewItem() {
        let newMemo = Memo(date: Date(), description: "")
        list.append(newMemo)
        let storyboard = UIStoryboard(name: "MemoDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoDetailViewController") as! MemoDetailViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.memo = newMemo
        vc.memoList  = list
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        list.sort()
        tableView.reloadData()
    }
}

extension MemoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoCell else {
            print("Failed casting to MemoCell")
            return UITableViewCell()
        }
        
        cell.configure(list[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delButton = UIContextualAction(style: .destructive, title: "삭제") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [delButton])
    }
    
}

extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MemoDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoDetailViewController") as! MemoDetailViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.memo = list[indexPath.item]
        vc.memoList = list
    }
}
