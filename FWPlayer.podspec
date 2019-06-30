#
# Be sure to run `pod lib lint FWPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FWPlayer'
  s.version          = '1.0.1'
  s.summary          = 'A video player SDK for iOS.'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
For more information, please see README.
                       DESC

  s.homepage         = 'https://fokswang.wixsite.com/home'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hui Wang' => 'foks.wang@gmail.com' }
  s.source           = { :git => 'https://github.com/FoksWang/FWPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '9.0'
  # s.ios.deployment_target = '8.0'

  # s.source_files = 'FWPlayer/Classes/**/*'
  # s.source_files = 'FWPlayer/Classes/*.{h,swift}'
  
  # s.resource_bundles = {
  #   'FWPlayer' => ['FWPlayer/Assets/*.png']
  # }

  s.ios.vendored_frameworks   = 'FWPlayer/Frameworks/*.framework'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
