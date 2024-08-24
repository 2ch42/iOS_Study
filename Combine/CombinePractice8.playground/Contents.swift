import Foundation
import Combine

let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

//Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
//    print("Receive: \(str), \(num)")
//}

strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")

numPublisher.send(2)
numPublisher.send(3)

//----------------------------------

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validateCredentialSubscription = Publishers.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

usernamePublisher.send("jasonlee")
passwordPublisher.send("weakpw")
passwordPublisher.send("verystrongpassword")

let publisher1 = ["1", "2", "3", "4", "5"].publisher
let publisher2 = ["300", "400", "500"].publisher
//let publisher2 = [300, 400, 500].publisher -> 오퍼레이터인 Merge의 경우에 대해서, 정의를 보면 서로 다른 퍼블리셔들의 아웃풋 타입이 같아야 함.

let mergedPublishersSubscription = Publishers
    .Merge(publisher1, publisher2)
    .sink { value in
        print("Merge: subscription received value \(value)")
    }
