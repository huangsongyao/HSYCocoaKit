#
# Be sure to run `pod lib lint HSYCocoaKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSYCocoaKit'
  s.version          = '0.5.1'
  s.summary          = 'A short description of HSYCocoaKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huangsongyao/HSYCocoaKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangsongyao' => 'huangsongyao@foxmail.com' }
  s.source           = { :git => 'https://github.com/huangsongyao/HSYCocoaKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HSYCocoaKit/Classes/**/*'
  s.resource_bundles = {
    'HSYCocoaKit' => ['HSYCocoaKit/Assets/**/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'

#依赖的第三方库
s.dependency 'AFNetworking', '~> 3.1.0'
s.dependency 'JSONModel', '~> 1.7.0'
s.dependency 'Masonry', '~> 1.1.0'
s.dependency 'SDWebImage', '~> 4.3.3'
s.dependency 'MBProgressHUD', '~> 0.9.2'
s.dependency 'RegexKitLite', '~> 4.0'
s.dependency 'UITextView+Placeholder', '~> 1.1.1'
s.dependency 'TYAttributedLabel', '~> 2.6.6'
s.dependency 'FMDB', '~> 2.7.2'
s.dependency 'TKRoundedView', '~> 0.5'
s.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.6'
s.dependency 'CocoaAsyncSocket', '~> 7.6.3'
s.dependency 'lottie-ios', '~> 2.5.0'

end
