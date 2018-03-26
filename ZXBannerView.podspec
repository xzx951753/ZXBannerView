#
# Be sure to run `pod lib lint ZXBannerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZXBannerView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZXBannerView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xzx951753/ZXBannerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Xie zexin' => '285644797@qq.com' }
  s.source           = { :git => '/Users/xiezexin/Documents/GitHub/ZXBannerView', :tag => '0.1.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'ZXBannerView' => ['ZXBannerView/Assets/*.png']
  # }
  s.source_files = 'ZXBannerView/Classes/**/*'
  s.public_header_files = 'ZXBannerView/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SDWebImage', '~> 4.3.2'
  s.dependency 'Masonry', '~> 1.1.0'
end
