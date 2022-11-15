Pod::Spec.new do |s|
  s.name = 'MediatagSDK'
  s.version = '1.0.0'
  s.license = { :type => "MIT", :text => "MIT License" }
  s.summary = 'MediatagSDK framework'
  s.homepage = 'https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin'
  s.authors = { 'miromax21' => 'miromax21@gmail.com' }
  
  
  s.source = { :http => 'https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/archive/refs/tags/1.0.0.zip' }
  s.ios.vendored_frameworks = 'mediatag-sdk-ios-bin-1.0.0/MediatagSDK.xcframework'
  s.swift_version = '4.0'
  s.platform = :ios, '12.0'
  s.requires_arc = true
end
