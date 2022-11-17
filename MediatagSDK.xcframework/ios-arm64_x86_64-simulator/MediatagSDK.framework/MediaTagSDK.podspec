
Pod::Spec.new do |s|
  s.name = 'MediaTagSDK'
  s.version = '1.0.7'
  s.license = 'MIT'
  s.summary = 'MediatagSDK framework'
  s.homepage = 'https://github.com/cifrasoft/media-tag-sdk/'
  s.authors = { 'miromax21' => 'miromax21@gmail.com' }
  
  s.source = { :git => 'https://github.com/cifrasoft/media-tag-sdk.git', :tag => s.version.to_s }
  s.source_files = 'Sources/*.swift', 'Sources/extentions/*.swift', 'Sources/models/*.swift', 'Sources/NS/*.swift'
  s.swift_version = '4.0'
  s.platform = :ios, '12.0'

end