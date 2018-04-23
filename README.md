# HSYCocoaKit
<<<<<<< HEAD

[![CI Status](http://img.shields.io/travis/huangsongyao/HSYCocoaKit.svg?style=flat)](https://travis-ci.org/huangsongyao/HSYCocoaKit)
[![Version](https://img.shields.io/cocoapods/v/HSYCocoaKit.svg?style=flat)](http://cocoapods.org/pods/HSYCocoaKit)
[![License](https://img.shields.io/cocoapods/l/HSYCocoaKit.svg?style=flat)](http://cocoapods.org/pods/HSYCocoaKit)
[![Platform](https://img.shields.io/cocoapods/p/HSYCocoaKit.svg?style=flat)](http://cocoapods.org/pods/HSYCocoaKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HSYCocoaKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HSYCocoaKit"
```

## Author

huangsongyao, huangsongyao@foxmail.com

## License

HSYCocoaKit is available under the MIT license. See the LICENSE file for more info.
=======
iOS开发私有库
>>>>>>> 51c3df2ed8a41866953d1b63b4e0c75cab356438


使用说明：
1.打开终端，执行pod repo list
获取当前Mac设备的repo list

2.如果repo list中不存在私有库地址，则执行 pod repo add xxx https://github.com/huangsongyao/HSYCocoaKit    (xxx表示add到本地的repo名称，可以随意取)

3.创建一个demo或者在需要添加的工程，cd到根目录下，执行vim Podfile
pod的ruby编写的demo如下：

platform :ios, '8.0'

target '你的项目的.xcodeproj名称' do
        pod 'HSYCocoaKit', :git => 'https://github.com/huangsongyao/HSYCocoaKit.git'
end

4.点击ESC退出编辑模式，执行 :wq ,保持并退出

5.于当前根目录下执行：pod install/pod update

