import Foundation
import UIKit
import Combine

struct SomeDecodable: Decodable { }

URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!)
    .map { data, response  in
        return data
    }
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())

let center = NotificationCenter.default
let notif = Notification.Name("MyNotif")
let notiPublisher = center.publisher(for: notif, object: nil)
let subscription1 = notiPublisher.sink { _ in
    print("Noti received")
}
center.post(name: notif, object: nil)
subscription1.cancel()

let ageLabel = UILabel()
print("text: \(ageLabel.text)")

Just(28)
    .map { "Age is \($0)"}
    .assign(to: \.text, on: ageLabel)

print("text: \(ageLabel.text)")

let timerPublisher = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

let subscription2 = timerPublisher.sink { time in
    print("time: \(time)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription2.cancel()
}
