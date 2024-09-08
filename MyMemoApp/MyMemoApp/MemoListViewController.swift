//
//  ViewController.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/6/24.
//

import UIKit

class MemoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list: [Memo] = Memo.sampleList.sorted()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        let addItemButton = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = addItemButton
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        
        let delButton = UIContextualAction(style: .destructive, title: "delete") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
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
