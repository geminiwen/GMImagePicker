#
#  Be sure to run `pod spec lint GMImagePicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
Pod::Spec.new do |s|
  s.name         = "GMImagePicker"
  s.version      = "0.1.1"
  s.summary      = "Yet another image picker"

  s.description  = <<-DESC
      Yet another image picker with Photo Browser
                   DESC

  s.homepage     = "https://github.com/geminiwen/GMImagePicker"



  s.license      = "MIT"

  s.author       = { "Gemini Wen" => "geminiwen@aliyun.com" }

  s.source       = { :git => "https://github.com/geminiwen/GMImagePicker.git", :commit => "5aea44d1fcf6f09549146ae2f8ffe07fb378ede3" }

  s.source_files  = "GMImagePicker", "GMImagePicker/**/*.{h,m}"
 
  s.resources = "GMImagePicker/Media.xcassets/**/*.png"
  s.resource_bundles = "GMImagePicker/*.{lproj,storyboard}"




end
