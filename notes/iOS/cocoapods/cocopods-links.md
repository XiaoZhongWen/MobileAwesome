### 🐢 [Care and Feeding of Xcode Configurations](http://americanexpress.io/care-and-feeding-of-xcode-configurations)

Xcode 默认的 `build setting` 机制在团队协作中经常会因误操作等原因导致编译问题，文章介绍了引入 `xcconfig` 文件来解决此类问题(如果你使用了 `Cocoapods`，那么你已经引入了)，由此带来 `share configurations`、`change history` 等好处，最后还介绍了如何组织 `xcconfig` 文件以及一些 `ProTips`。



### 🐢 [『如何使用现代的 App 工程与架构的技术来构建我们的 App』系列文章](https://www.hackingwithswift.com/articles/94/how-to-refactor-your-app-to-add-unit-tests)

- [How to refactor your app to add unit tests](https://www.hackingwithswift.com/articles/94/how-to-refactor-your-app-to-add-unit-tests)
- [How to add CocoaPods to your project](https://www.hackingwithswift.com/articles/95/how-to-add-cocoapods-to-your-project)
- [How to clean up your code formatting with SwiftLint](https://www.hackingwithswift.com/articles/97/how-to-clean-up-your-code-formatting-with-swiftlint)
- [How to streamline your development with Fastlane](https://www.hackingwithswift.com/articles/98/how-to-streamline-your-development-with-fastlane)

上述四篇是一个系列文章， 围绕一个核心问题来讲述：如何使用现代的 App 工程与架构的技术来构建我们的 App。不得不说作者写的是很良心的，整体文风对新手都很友好而且做到了循序渐进、抽丝剥茧的叙事逻辑，是不可多得的项目教程。

系列文章从一个普通的、设计缺乏考量的 demo 工程开始，首先为其添加了单元测试框架的支持，然后整合了 CocoaPods 来管理第三方的依赖，引入了 SwiftLint 来对代码进行静态检查，最终介绍了如何配置 Fastlane 来把传统打包提审流程中最繁琐的截屏步骤给自动化。基本涵盖了现在的 iOS App 项目的核心工程要素，尤其适合小公司的“多面手”型工程师阅读。



### 🐕 [CocoaPods 进阶之利用 Subspec 实现代码“模块化”](https://xiaozhuanlan.com/topic/1085467293)

老司机小专栏的文章，主要讲如何利用 Subspec 对 framework 内部代码进行模块化，让调用者做到「按需引入」。



### [CocoaPods 历险记](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzA5MTM1NTc2Ng==&action=getalbum&album_id=1477103239887142918&scene=173&from_msgid=2458322728&from_itemidx=1&count=3&nolastread=1#wechat_redirect)



