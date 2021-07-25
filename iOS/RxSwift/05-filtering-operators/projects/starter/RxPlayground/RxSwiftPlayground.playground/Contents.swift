import Foundation
import RxSwift

enum FilterError : Error {
    case filter_error
}

example(of: "ignoreElements") {
    let strikes = PublishSubject<String>.init()
    let disposeBag = DisposeBag()
    
    strikes.ignoreElements().subscribe { _ in
        print("You're out!")
    }.disposed(by: disposeBag)
    
    strikes.onNext("x")
    strikes.onNext("x")
    strikes.onNext("x")
//    strikes.onError(FilterError.filter_error)
    strikes.onCompleted()

}

example(of: "elementAt") {
    let strikes = PublishSubject<String>.init()
    let disposeBag = DisposeBag()
    strikes.elementAt(1).subscribe { e in
        print(e.element ?? "")
    }.disposed(by: disposeBag)
    
    strikes.onNext("1")
    strikes.onNext("2")
    strikes.onNext("3")
}

example(of: "filter") {
    let observable = Observable.of(1, 2, 3, 4, 5, 6)
    let disposeBag = DisposeBag()
    observable.filter {
        $0.isMultiple(of: 2)
    }.subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "skip") {
    let observable = Observable.of("A","B","C","D","E","F")
    let disposeBag = DisposeBag()
    observable.skip(3).subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "skipWhile") {
    let observable = Observable.of(2, 2, 3, 4, 4)
    let disposeBag = DisposeBag()
    observable.skipWhile {
        $0.isMultiple(of: 2)
    }.subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "skipUntil") {
    let subject = PublishSubject<String>.init()
    let triggle = PublishSubject<String>.init()
    let disposeBag = DisposeBag()
    subject.skipUntil(triggle).subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
    subject.onNext("A")
    subject.onNext("B")
    
    triggle.onNext("-")
    
    subject.onNext("C")
}

example(of: "take") {
    let observable = Observable.of(2, 2, 3, 4, 4)
    let disposeBag = DisposeBag()
    observable.take(3).subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "takeWhile") {
    let observable = Observable.of(2, 2, 4, 4, 6, 6)
    let disposeBag = DisposeBag()
    observable.enumerated().takeWhile { (index, element) in
        element.isMultiple(of: 2) && index < 3
    }.map(\.element).subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "takeUntil") {
    let observable = Observable.of(1, 2, 3, 4, 5, 6)
    let disposeBag = DisposeBag()
    observable.takeUntil(.exclusive) {
        $0.isMultiple(of: 4)
    }.subscribe(onNext: { element in
        print(element)
    }).disposed(by: disposeBag)
}

example(of: "takeUntil trigger") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>.init()
    let triggle = PublishSubject<String>.init()
    subject.takeUntil(triggle).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    
    triggle.onNext("X")
    
    subject.onNext("C")
}

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
