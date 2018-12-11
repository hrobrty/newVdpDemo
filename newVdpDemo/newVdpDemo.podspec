
Pod::Spec.new do |s|
  s.name             = 'LegrandVDPSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LegrandVDPSDK.'
  s.homepage         = 'https://github.com/hrobrty/LegrandVDPSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hrobrty' => '1053013584@qq.com' }
  s.source           = { :git => 'https://github.com/hrobrty/LegrandVDPSDK.git', :tag => 'v0.1.0' }
  s.ios.deployment_target = '8.0'
  s.source_files = 'newVdpDemo/SDK/**/*'

end
