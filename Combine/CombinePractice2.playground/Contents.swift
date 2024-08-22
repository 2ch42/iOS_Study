import Foundation
import Combine

let relay = PassthroughSubject<String, Never>()
// subject인 PassthroughSubject와 CurrentValueSubject는 Publisher로써 output type과 error type을 정의.

let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

// print(relay.value) -> relay는 PassthroughSubject로 보낸 값을 가지고 있지 않아서 relay.value라는 것 자체가 존재 X

let variable = CurrentValueSubject<String, Never>("")
// CurrentValueSubject는 PassthroughSubject와 달리 Output type의 초기값을 넣어줘야함.

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More Text")

print(variable.value)  // -> variable은 CurrentValueSubject로 보낸 값을 가지고 있어서 variable.value가 존재함.

let publisher = ["Here", "We", "Go"].publisher

publisher.subscribe(relay)
