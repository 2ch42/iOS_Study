import Foundation
import UIKit
import Combine

final class SomeViewModel {
    @Published var name: String = "Jack"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()

print(label.text)

vm.$name.assign(to: \.text, on: label)
print(label.text)

vm.name = "Jason"
print(label.text)

vm.name = "Alex"
print(label.text)
