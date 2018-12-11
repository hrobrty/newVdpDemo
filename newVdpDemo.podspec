
Pod::Spec.new do |s|
  s.name             = 'newVdpDemo'
  s.version          = '1.0.0'
  s.summary          = 'A short description of newVdpDemo.'
  s.homepage         = 'https://github.com/hrobrty/newVdpDemo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hrobrty' => '1053013584@qq.com' }
  s.source           = { :git => 'https://github.com/hrobrty/newVdpDemo.git', :tag => '1.0.0' }
  s.ios.deployment_target = '8.0'
  s.source_files = 'newVdpDemo/newVdpDemo/SDK/**/*'
  s.frameworks = "Foundation","UIKit"
end
