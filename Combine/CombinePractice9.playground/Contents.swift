import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher

words
    .removeDuplicates()
    .sink(receiveValue: {
        print($0)
    })
    .store(in: &subscriptions)

let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
    .compactMap { Float($0) }
    .sink(receiveValue: {
        print($0)
    })
    .store(in: &subscriptions)

let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

let tens = (1...10).publisher

tens
  .prefix(2)
  .sink(receiveCompletion: { print("Completed with: \($0)") },
        receiveValue: { print($0) })
  .store(in: &subscriptions)
