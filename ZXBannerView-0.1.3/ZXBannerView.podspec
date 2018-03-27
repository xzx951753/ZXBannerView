Pod::Spec.new do |s|
  s.name = "ZXBannerView"
  s.version = "0.1.3"
  s.summary = "A simple cycle banner view by OC, depends Masonry and SDWebimage,support touch block."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Xie zexin"=>"285644797@qq.com"}
  s.homepage = "https://github.com/xzx951753/ZXBannerView"
  s.description = "TODO: ZXBannerView is a cycle banner view. You can create object by initWithFrame or direct init after then masonry make layouts. ZXBannerView use block method handle touch event, but you need confirm image and link arrays was corrected,  They were encapsulation in 'ZXBannerData' classes.,"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZXBannerView.framework'
end
