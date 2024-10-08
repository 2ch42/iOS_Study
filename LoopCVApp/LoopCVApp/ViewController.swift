//
//  ViewController.swift
//  LoopCVApp
//
//  Created by ch on 10/8/24.
//

import UIKit

class ViewController: UIViewController {

  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.isPagingEnabled = true
    return cv
  }()

  var list: [TestModel] = TestModel.sampleData
  var extendedList: [TestModel] = []
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for i in 0...2 {
      for j in 0..<list.count {
        var newElement = list[j]
        if i != 0 { newElement.id = UUID() }
        extendedList.append(newElement)
      }
    }

    self.view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    ])
    
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)

    collectionView.isPagingEnabled = true
    
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return extendedList.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configure(extendedList[indexPath.item])
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
}

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.frame.width
    let offset = scrollView.contentOffset.x
    let currentPage = Int(offset / pageWidth)

    if currentPage >= extendedList.count - 1 {
      collectionView.setContentOffset(CGPoint(x: 2 * pageWidth, y: 0), animated: false)
    }
    
    if currentPage <= 0 {
      collectionView.setContentOffset(CGPoint(x: 3 * pageWidth, y: 0), animated: false)
    }
  }
}
