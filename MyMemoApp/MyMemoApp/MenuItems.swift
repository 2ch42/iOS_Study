//
//  MenuItems.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/29/24.
//

import Foundation
import UIKit

struct MenuItems {

  static var listMenuItems: [UIAction] = [UIAction(title: "갤러리로 보기", image: UIImage(systemName: "square.grid.2x2"), handler: { UIAction in
    return
  }), UIAction(title: "메모 선택", image: UIImage(systemName: "checkmark.circle"), handler: { UIAction in
    return
  }), UIAction(title: "다음으로 정렬", image: UIImage(systemName: "arrow.up.arrow.down"), handler: { UIAction in
    return
  }), UIAction(title: "날짜별로 그룹화", image: UIImage(systemName: "calendar"), handler: { UIAction in
    return
  }), UIAction(title: "첨부 파일 보기", image: UIImage(systemName: "paperclip"), handler: { UIAction in
    return
  })]

  static var detailMenuItems: [UIAction] = [UIAction(title: "메모에서 찾기", image: UIImage(systemName: "magnifyingglass"), handler: { UIAction in
    return
  }), UIAction(title: "메모 이동", image: UIImage(systemName: "folder"), handler: { UIAction in
    return
  }), UIAction(title: "줄 및 격자", image: UIImage(systemName: "rectangle.split.3x3"), handler: { UIAction in
    return
  }), UIAction(title: "첨부 파일 보기", image: UIImage(systemName: "rectangle.3.group"), handler: { UIAction in
    return
  }), UIAction(title: "밝은 배경 사용", image: UIImage(systemName: "circle.lefthalf.filled")?.withTintColor(.systemBlue), handler: { UIAction in
    return
  }), UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { UIAction in
    return
  })]
}


