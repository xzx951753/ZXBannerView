Pod::Spec.new do |s|
  s.name = "ZXBannerView"
  s.version = "0.1.1"
  s.summary = "A short description of ZXBannerView."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Xie zexin"=>"285644797@qq.com"}
  s.homepage = "https://github.com/xzx951753/ZXBannerView"
  s.description = "TODO: Add long description of the pod here."
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZXBannerView.framework'
end
