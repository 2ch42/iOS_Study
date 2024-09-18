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

    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }

    @Published var list: [MemoDummies] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        list = readData()
//        list.sort { lhs, rhs in
//            return rhs.date! < lhs.date!
//        }
        
        
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

        let storyboard = UIStoryboard(name: "MemoDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoDetailViewController") as! MemoDetailViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.afterUnload = { [unowned self] memo, content in
            self.createData(content)
            self.list = readData()
            self.tableView.insertRows(at: [IndexPath(row: list.count - 1, section: 0)], with: .none)
//            self.tableView.reloadRows(at: [IndexPath(row: list.count, section: 0)], with: .none)
            if let memoCountsText = self.toolBar.items?.first(where: { $0.title?.contains("개의 메모") == true }) {
                memoCountsText.title = "\(self.list.count)개의 메모"
                }
        }
    }
    
    func createData(_ content: String) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newMemo = MemoDummies(context: context)
        
        newMemo.id = UUID()
        newMemo.date = Date()
        newMemo.content = content
        
        try? context.save()
    }
    
    func readData() -> [MemoDummies] {

        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = MemoDummies.fetchRequest()

        guard let memoList = try? context.fetch(request) else { return [] }
        return memoList
    }
    
    func updateData(_ memo: MemoDummies, _ content: String) {

        guard let context = self.persistentContainer?.viewContext else { return }

        let request = MemoDummies.fetchRequest()

        guard let memos = try? context.fetch(request) else { return }

        let willUpdateMemo = memos.filter({ $0.id == memo.id })

        willUpdateMemo[0].date = Date()
        willUpdateMemo[0].content = content

        try? context.save()
    }
    
    func deleteData(_ memo: MemoDummies) {

        guard let context = self.persistentContainer?.viewContext else { return }

        let willDeleteMemo = list.filter({ $0.date == memo.date && $0.content == memo.content })

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

        cell.configure(list[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delButton = UIContextualAction(style: .destructive, title: "삭제") { [unowned self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            deleteData(list[indexPath.item])
            list = readData()
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
        vc.memo = list[indexPath.item]
        vc.afterUnload = { [unowned self] memo, content in
            if memo!.content == "" {
                deleteData(list[indexPath.item])
                self.list = readData()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                if let memoCountsText = self.toolBar.items?.first(where: { $0.title?.contains("개의 메모") == true }) {
                        memoCountsText.title = "\(list.count)개의 메모"
                    }
            } else {
                updateData(memo!, content)
                list = readData()
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
