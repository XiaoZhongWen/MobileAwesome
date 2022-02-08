import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "collect") {
//    ["A", "B", "C", "D", "E"].publisher.sink {
//        print($0)
//    } receiveValue: {
//        print($0)
//    }.store(in: &subscriptions)
//
//
//    ["A", "B", "C", "D", "E"].publisher.collect(3).sink {
//        print($0)
//    } receiveValue: {
//        print($0)
//    }

    [1, 2, 3].publisher.map { e in
        e * e
    }.sink {
        print($0)
    } receiveValue: {
        print($0)
    }.store(in: &subscriptions)
}

example(of: "mapping key paths") {
    let publisher = PassthroughSubject<Coordinate, Never>()
    publisher.map(\.x, \.y).sink { (x, y) in
        print(
                "The coordinate at (\(x), \(y)) is in quadrant",
                quadrantOf(x: x, y: y)
              )
    }.store(in: &subscriptions)

    publisher.send(Coordinate(x: 10, y: -8))
    publisher.send(Coordinate(x: 0, y: 5))
}

//example(of: "tryMap") {
//    Just("Directory name that does not exist").tryMap {
//        try FileManager.default.contentsOfDirectory(atPath: $0)
//    }.sink {
//        print($0)
//        print("completion")
//    } receiveValue: {
//        print($0)
//    }.store(in: &subscriptions)
//
//}

example(of: "flapMap") {
    func decode(_ codes:[Int]) -> AnyPublisher<String, Never> {
        Just(codes.compactMap({ code in
            guard (32...255).contains(code) else {return nil}
            return String(UnicodeScalar(code) ?? " ")
        }).joined()).eraseToAnyPublisher()
    }
    [72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33]
        .publisher
        .collect()
        .flatMap(decode)
        .sink {
            print($0)
        }.store(in: &subscriptions)
}

example(of: "scan") {
  // 1
  var dailyGainLoss: Int { .random(in: -10...10) }

  // 2
  let august2019 = (0..<22)
    .map { _ in dailyGainLoss }
    .publisher

  // 3
  august2019
    .scan(50) { latest, current in
      max(0, latest + current)
    }
    .sink(receiveValue: { _ in })
    .store(in: &subscriptions)
}


/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

