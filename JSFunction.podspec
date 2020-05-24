#
# Be sure to run `pod lib lint JSFunction.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JSFunction'
  s.version          = '0.1.0'
  s.summary          = 'WKWebView Javascript call Class function'
  s.homepage         = 'https://github.com/outofcoding/JSFunction'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OutOfCode' => 'outofcoding@gmail.com' }
  s.source           = { :git => 'https://github.com/outofcoding/JSFunction.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'JSFunction/Classes/**/*'
  s.requires_arc = true
  s.swift_version = '4.0'
end
