#
#  Be sure to run `pod spec lint GMImagePicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
Pod::Spec.new do |s|
  s.name         = "GMImagePicker"
  s.version      = "0.1.0"
  s.summary      = "Yet another image picker"

  s.description  = <<-DESC
      Yet another image picker with Photo Browser
                   DESC

  s.homepage     = "https://github.com/geminiwen/GMImagePicker"
  s.social_media_url = 'http://weibo.com/coffeesherk'
  s.license      = "MIT"
  s.author       = { "Gemini Wen" => "coffeesherk@gmail.com" }

  s.source       = { :git => "https://github.com/geminiwen/GMImagePicker.git", :tag => s.version.to_s }

  s.source_files  = 'GMImagePicker/**/*.{h,m}'
 
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.resources = "GMImagePicker/Media.xcassets/**/*.png"

  s.resource_bundles = { 'GMImagePicker' => "GMImagePicker/*.{lproj,storyboard}"}
  s.frameworks       = "Photos"
  s.dependency "pop"


end
