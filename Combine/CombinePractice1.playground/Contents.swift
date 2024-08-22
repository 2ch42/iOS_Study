import Foundation
import Combine

let just = Just(1000) // just는 값을 다루는 built-in publisher
let subscription = just.sink { value in // sink는 Publisher가 제공한 데이터를 받을 수 있는 클로져 제공.
    print("Received Value: \(value)")
}

let arrayPublisher = [1, 3, 5, 7, 9].publisher
let subscription2 = arrayPublisher.sink { value in
    print("Received Value: \(value)")
}

class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = arrayPublisher.assign(to: \.property, on: object) // assign은 Publisher가 제공한 데이터를 특정 객체의 키패스에 저장하는 built-in Publisher

//object.property = 3
