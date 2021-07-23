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

import UIKit
import RxSwift
import RxRelay

class MainViewController: UIViewController {

  @IBOutlet weak var imagePreview: UIImageView!
  @IBOutlet weak var buttonClear: UIButton!
  @IBOutlet weak var buttonSave: UIButton!
  @IBOutlet weak var itemAdd: UIBarButtonItem!

  private let images = BehaviorRelay<[UIImage]>.init(value: [])
  private let disposeBag = DisposeBag.init()

  override func viewDidLoad() {
    super.viewDidLoad()
    images.subscribe(onNext: { [weak imagePreview] phtots in
      guard let preview = imagePreview else { return }
      preview.image = phtots.collage(size: preview.frame.size)
    }).disposed(by: disposeBag)

    images.subscribe(onNext: { [weak self] photos in
      self?.updateUI(photots: photos)
    }).disposed(by: disposeBag)
  }
  
  @IBAction func actionClear() {
    images.accept([])
  }

  @IBAction func actionSave() {

  }

  @IBAction func actionAdd() {
    let photosViewController = storyboard!.instantiateViewController(
      withIdentifier: "PhotosViewController") as! PhotosViewController
    photosViewController.selectedPhotos.subscribe(onNext: { [weak self] photo in
      guard let images = self?.images else { return }
      images.accept(images.value + [photo])
    },
    onDisposed: {
      print("Completed photo selection")
    }).disposed(by: disposeBag)
    navigationController!.pushViewController(photosViewController, animated: true)
//    let newImages = images.value + [UIImage.init(named: "IMG_1907.jpg")!]
//    images.accept(newImages)
  }

  private func updateUI(photots:[UIImage]) {
    buttonClear.isEnabled = photots.count > 0
    buttonSave.isEnabled = photots.count > 0 && photots.count % 2 == 0
    itemAdd.isEnabled = photots.count < 6
    title = photots.count > 0 ? "\(photots.count) photos" : "Collage"
  }

  func showMessage(_ title: String, description: String? = nil) {
    let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
    present(alert, animated: true, completion: nil)
  }
}
