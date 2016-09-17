# HaidoraNibDesignable

[![CI Status](http://img.shields.io/travis/mrdaios/HaidoraNibDesignable.svg?style=flat)](https://travis-ci.org/mrdaios/HaidoraNibDesignable)
[![Version](https://img.shields.io/cocoapods/v/HaidoraNibDesignable.svg?style=flat)](http://cocoapods.org/pods/HaidoraNibDesignable)
[![License](https://img.shields.io/cocoapods/l/HaidoraNibDesignable.svg?style=flat)](http://cocoapods.org/pods/HaidoraNibDesignable)
[![Platform](https://img.shields.io/cocoapods/p/HaidoraNibDesignable.svg?style=flat)](http://cocoapods.org/pods/HaidoraNibDesignable)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### 方式一

```swift
//1.引入库
import HaidoraNibDesignable
@IBDesignable
//2.实现HaidoraNibDesignable
class DesignableView: UIView,HaidoraNibDesignable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加nib文件到当前view
        self.setupNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //添加nib文件到当前view
        self.setupNib()
    }
}

```

#### 方式二

```swift
import HaidoraNibDesignable
//继承HaidoraNibDesignableView
class InputView: HaidoraNibDesignableView {

}


```

## Requirements
- xcode8+
- Swift3.0
- iOS8+

## Installation

HaidoraNibDesignable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
    pod "HaidoraNibDesignable"
```

## Inspired by these projects:
* [NibDesignable](https://github.com/mbogh/NibDesignable)
* [XXNibBridge](https://github.com/sunnyxx/XXNibBridge)

## Author

mrdaios, mrdaios@gmail.com

## License

HaidoraNibDesignable is available under the MIT license. See the LICENSE file for more info.