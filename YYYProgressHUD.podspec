#
# Be sure to run `pod lib lint YYYProgressHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name         = 'YYYProgressHUD'
  s.version      = '1.0.3'
  s.summary      = 'YYYProgressHUD'

  s.description  = '加载，文字提示'

  s.homepage         = 'https://github.com/276523923/YYYProgressHUD.git'
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { '276523923@qq.com' => 'yyyue@vip.qq.com' }

  s.source       = { :git => 'https://github.com/276523923/YYYProgressHUD.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  # s.static_framework = true

  s.source_files  = "YYYProgressHUD/Classes/**/*.{h,m}"
  s.public_header_files = "YYYProgressHUD/Classes/**/*.h"
  s.dependency 'YYYWeakProxy'

  # s.resources = "YYYProgressHUD/Assets/**/*"
#  s.resource_bundles = {
#    'YYYProgressHUD' => ["YYYProgressHUD/Assets/**/*"]
#  }

  # s.dependency ""
end
