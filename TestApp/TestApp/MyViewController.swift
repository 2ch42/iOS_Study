import UIKit

class MyViewController: UIViewController {
  
  var list: [TestModel] = TestModel.sampleData
  var extendedList: [TestModel] = []
  
  private let collectionView: UICollectionView = {
    let layout = MyViewController.layout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    return cv
  }()
  
  enum Section {
    case main
  }
  
  typealias Item = TestModel
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    for i in 0...2 {
      var tmp = list
      if i != 2 {
        for j in 0..<list.count {
          tmp[j].id = UUID()
        }
      }
      extendedList += tmp
    }
    
    self.view.addSubview(collectionView)
    
    collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseIdentifer)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    ])
    
//    collectionView.delegate = self
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.reuseIdentifer, for: indexPath) as? MyCell else {
        return nil
      }
      cell.configure(item)
      return cell
    })
    
    snapshot.appendSections([.main])
    snapshot.appendItems(extendedList, toSection: .main)
    dataSource.apply(snapshot)
    
//    collectionView.collectionViewLayout = layout()
  }
  
  static func layout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}

extension MyViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
    print(index)
  }
}
