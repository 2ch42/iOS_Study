//
//  FocusViewController.swift
//  OneThing
//
//  Created by ch on 11/5/24.
//

import UIKit

class FocusViewController: UIViewController {

  var focusTimer: FocusTimer? = nil

  var goal: String? = nil

  var timer: Timer? = nil

  var runCount: Int = 3

  var countDownLabel: UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.attributedText = NSAttributedString(string: "3", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 60), NSAttributedString.Key.foregroundColor: UIColor.white])
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(countDownLabel)

    countDownLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      countDownLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      countDownLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      countDownLabel.widthAnchor.constraint(equalToConstant: 150),
      countDownLabel.heightAnchor.constraint(equalToConstant: 150)
    ])

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let vc = GoalModalViewController()
    
    vc.setGoal = { [weak self] goal in
      guard let self = self else { return }
      self.goal = goal
    }

    vc.startCountDown = { [weak self] in

      guard let self = self else { return }

      self.startCountDownTimer()
    }

    self.present(vc, animated: true)    
  }

  func startCountDownTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countPerSecond), userInfo: nil, repeats: true)
  }

  @objc func countPerSecond() {
    runCount -= 1

    if runCount == 0 {
      timer?.invalidate()
      self.countDownLabel.isHidden = true
      self.countDownLabel.isEnabled = false
    } else {
      self.countDownLabel.text = "\(runCount)"
    }
  }
}
