import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

let subscription = subject
    .print("[DEBUG]")
    .sink { value in
     print("subscriber received value: \(value)")
}

subject.send("Hello")
subject.send("Hello 2nd")
subject.send("Hello 3rd")
//subject.send(completion: .finished)
subscription.cancel()
subject.send("RETRY")
