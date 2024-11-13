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
  
  var isRunning: Bool = false
  
  var countDownLabel: UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.attributedText = NSAttributedString(string: "3", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 60), NSAttributedString.Key.foregroundColor: UIColor.white])
    label.isHidden = true
    return label
  }()
  
  var quoteLabel: UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.attributedText = NSAttributedString(string: "default", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
    label.isHidden = true
    return label
  }()
  
  var timerLabel: UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.attributedText = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 80), NSAttributedString.Key.foregroundColor: UIColor.white])
    label.isHidden = true
    label.isEnabled = false
    return label
  }()
  
  var stopButton: UIButton = {
    var button = UIButton()
    button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    button.setTitle("잠시 휴식", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 20
    button.isHidden = true
    button.isEnabled = false
    return button
  }()

  var resumeButton: UIButton = {
    var button = UIButton()
    button.addTarget(self, action: #selector(resumeTimer), for: .touchUpInside)
    button.setTitle("다시 시작", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 20
    button.isHidden = true
    button.isEnabled = false
    return button
  }()

  var quitButton: UIButton = {
    var button = UIButton()
    button.addTarget(self, action: #selector(quitTimer), for: .touchUpInside)
    button.setTitle("집중 마치기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 20
    button.isHidden = true
    button.isEnabled = false
    return button
  }()

  var minute: Int = 0
  var second: Int = 0
  var targetMinute: Int? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(countDownLabel)
    self.view.addSubview(timerLabel)
    self.view.addSubview(stopButton)
    self.view.addSubview(resumeButton)
    self.view.addSubview(quitButton)

    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.navigationBar.isHidden = true

    countDownLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    stopButton.translatesAutoresizingMaskIntoConstraints = false
    resumeButton.translatesAutoresizingMaskIntoConstraints = false
    quitButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      countDownLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      countDownLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:  -20),
      countDownLabel.widthAnchor.constraint(equalToConstant: 150),
      countDownLabel.heightAnchor.constraint(equalToConstant: 150),
      timerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      timerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
      timerLabel.widthAnchor.constraint(equalToConstant: 250),
      timerLabel.heightAnchor.constraint(equalToConstant: 150),
      stopButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80),
      stopButton.widthAnchor.constraint(equalToConstant: 120),
      stopButton.heightAnchor.constraint(equalToConstant: 50),
      stopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 150),
      resumeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80),
      resumeButton.widthAnchor.constraint(equalToConstant: 120),
      resumeButton.heightAnchor.constraint(equalToConstant: 50),
      resumeButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 150),
      quitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80),
      quitButton.widthAnchor.constraint(equalToConstant: 120),
      quitButton.heightAnchor.constraint(equalToConstant: 50),
      quitButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 150),
    ])

  }

  override func viewWillDisappear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
    self.navigationController?.navigationBar.isHidden = false
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

      self.targetMinute = self.focusTimer?.targetMinute

      self.countDownLabel.isHidden = false

      self.beforeStartTimer()
    }

    self.present(vc, animated: true)
  }

  func beforeStartTimer() {
    if let goalString = goal, let quote = quoteLabel.text {
      quoteLabel.text = goalString + quote
    }
    quoteLabel.isHidden = false
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownPerSecond), userInfo: nil, repeats: true)
  }

  func startTargetTimer() {
    stopButton.isHidden = false
    stopButton.isEnabled = true
    quitButton.isHidden = false
    quitButton.isEnabled = true

    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countUpPerSecond), userInfo: nil, repeats: true)
    isRunning = true
  }

  @objc func countDownPerSecond() {
    runCount -= 1
    
    if runCount == 0 {
      timer?.invalidate()
      self.countDownLabel.isHidden = true
      self.countDownLabel.isEnabled = false
      self.timerLabel.isHidden = false
      self.timerLabel.isEnabled = true
      startTargetTimer()
    } else {
      self.countDownLabel.text = "\(runCount)"
    }
  }
  
  @objc func countUpPerSecond() {
    self.second += 1
    
    if second == 60 {
      self.minute += 1
      self.second = 0
    }
    
    var minuteText = self.minute.formatted()
    var secondText = self.second.formatted()
    
    if minuteText.count == 1 {
      minuteText = "0" + minuteText
    }
    if secondText.count == 1 {
      secondText = "0" + secondText
    }
    self.timerLabel.text = "\(minuteText):\(secondText)"
    
    if self.minute == self.targetMinute {
      timer?.invalidate()
      timer = nil
      self.focusTimer?.success = true
    }
  }

  @objc func stopTimer() {
    timer?.invalidate()
    stopButton.isEnabled = false
    stopButton.isHidden = true
    resumeButton.isHidden = false
    resumeButton.isEnabled = true
    isRunning = false
  }

  @objc func resumeTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countUpPerSecond), userInfo: nil, repeats: true)
    resumeButton.isEnabled = false
    resumeButton.isHidden = true
    stopButton.isHidden = false
    stopButton.isEnabled = true
    isRunning = true
  }

  @objc func quitTimer() {
    // 추후에 alert로 한번 더 물어보는 방식으로 수정해야 함.
    // Todo : 다른 앱 접근 권한 건드리기, 데이터 어떤 식으로 저장할지 생각
    timer?.invalidate()
    self.navigationController?.popViewController(animated: true)
    self.navigationController?.navigationBar.isHidden = false
    self.tabBarController?.tabBar.isHidden = false
  }
}
