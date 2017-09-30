
Pod::Spec.new do |s|
  s.name         = "SwiftHelpers"
  s.version      = "0.0.0"
  s.summary      = ""
  s.homepage     = "https://github.com/jeksys/SwiftHelpers"
  s.license      = "MIT"
  s.author       = { "Eugene Yagrushkin" => "yagrushkin@gmail.com" }
  s.social_media_url   = "https://jeksys.github.io/"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/jeksys/SwiftHelpers.git", :tag => s.version.to_s }
  s.source_files = "DB6/Sources/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end
