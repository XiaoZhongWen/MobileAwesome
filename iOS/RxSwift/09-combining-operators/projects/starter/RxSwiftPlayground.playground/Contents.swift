import Foundation
import RxSwift
import RxRelay
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "startWith") {
    let numbers = Observable.of(2, 3, 4)
    let observable = numbers.startWith(1)
    observable.subscribe(onNext: {
        print($0)
    })
}

example(of: "Observable.concat") {
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    Observable.concat([first, second])
        .subscribe(onNext: {
            print($0)
        })
}

example(of: "concat") {
    let germanCities = Observable.of("Berlin", "Münich", "Frankfurt")
    let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")
    let observable = germanCities.concat(spanishCities)
    observable.subscribe(onNext: {
        print($0)
    })
}

example(of: "concat1") {
    let source = BehaviorRelay<[String]>.init(value: [])
    source.asObservable().subscribe(onNext: {
        print($0)
    })

    let observable1 = PublishSubject<[String]>.init()
    let observable2 = PublishSubject<[String]>.init()
    observable1.concat(observable2).bind(to: source)

    observable1.onNext(["1-A"])
    observable1.onCompleted()
//    observable1.onNext(["1-B"])
//    observable1.onNext(["1-C"])

    observable2.onNext(["2-A"])
//    observable2.onNext(["2-B"])
//    observable2.onNext(["2-C"])
}

example(of: "concatMap") {
    let sequences = [
        "German cities": Observable.of("Berlin", "Münich", "Frankfurt"),
        "Spanish cities": Observable.of("Madrid", "Barcelona", "Valencia")
      ]
    let observable = Observable.of("German cities", "Spanish cities").concatMap {
        country in
        sequences[country] ?? Observable.empty()
    }.subscribe(onNext: {
        print($0)
    })
}

example(of: "merge") {
    let left = PublishSubject<String>.init()
    let right = PublishSubject<String>.init()

    let observable = Observable.of(left, right)
    observable.merge()
        .subscribe(onNext: {
            print($0)
        })
    var leftValues = ["Berlin", "Münich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]
    repeat {
        switch Bool.random() {
        case true where !leftValues.isEmpty:
            left.onNext("Left " + leftValues.removeLast())
        case false where !rightValues.isEmpty:
            right.onNext("Right " + rightValues.removeLast())
        default:
            break
        }
    } while !leftValues.isEmpty && !rightValues.isEmpty

    left.onCompleted()
    right.onCompleted()
}

example(of: "combineLatest") {
    let left = PublishSubject<String>.init()
    let right = PublishSubject<String>.init()

    let observable = Observable.combineLatest(left, right) {
        lastLeft, lastRight in
        return "\(lastLeft) \(lastRight)"
    }

    observable.subscribe(onNext: {
        print($0)
    })

    print("> Sending a value to Left")
    left.onNext("Hello,")
    print("> Sending a value to Right")
    right.onNext("world")
    print("> Sending another value to Right")
    right.onNext("RxSwift")
    print("> Sending another value to Left")
    left.onNext("Have a good day,")

    left.onCompleted()
    right.onCompleted()
}

example(of: "zip") {
    enum Weather {
        case cloudy
        case sunny
    }

    let left = Observable<Weather>.of(.sunny, .cloudy, .cloudy, .sunny)
    let right = Observable<String>.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")
    let observable = Observable.zip(left, right) { weather, city in
        return "It's \(weather) in \(city)"
    }

    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "withLatestFrom") {
    let button = PublishSubject<Void>.init()
    let textfield = PublishSubject<String>.init()

    let observable = button.withLatestFrom(textfield)
    observable.subscribe(onNext: {
        print($0)
    })

    textfield.onNext("Par")
    textfield.onNext("Pari")
    textfield.onNext("Paris")
    button.onNext(())
    button.onNext(())
}

example(of: "amb") {
    let left = PublishSubject<String>.init()
    let right = PublishSubject<String>.init()

    let observable = left.amb(right)
    observable.subscribe(onNext: {
        print($0)
    })

    left.onNext("Lisbon")
    right.onNext("Copenhagen")
    left.onNext("London")
    left.onNext("Madrid")
    right.onNext("Vienna")

    left.onCompleted()
    right.onCompleted()
}

example(of: "switchLatest") {
    let one = PublishSubject<String>.init()
    let two = PublishSubject<String>.init()
    let three = PublishSubject<String>.init()

    let source = PublishSubject<PublishSubject<String>>.init()

    let observable = source.switchLatest()
    let dispose = observable.subscribe(onNext: {
        print($0)
    })

    source.onNext(one)
      one.onNext("Some text from sequence one")
      two.onNext("Some text from sequence two")

      source.onNext(two)
      two.onNext("More text from sequence two")
      one.onNext("and also from sequence one")

      source.onNext(three)
      two.onNext("Why don't you see me?")
      one.onNext("I'm alone, help me")
      three.onNext("Hey it's three. I win.")

      source.onNext(one)
      one.onNext("Nope. It's me, one!")

    dispose.dispose()
}

example(of: "reduce") {
    let source = Observable.of(1, 3, 5, 7, 9)
    source.reduce(0, accumulator: +).subscribe(onNext: {
        print($0)
    })
}

example(of: "scan") {
    let source = Observable.of(1, 3, 5, 7, 9)
    source.scan(0, accumulator: +).subscribe(onNext: {
        print($0)
    })
}

// Start coding here!

/// Copyright (c) 2020 Razeware LLC
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
