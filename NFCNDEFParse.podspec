#
# Be sure to run `pod lib lint NFCNDEFParse.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NFCNDEFParse'
  s.version          = '0.1.0'
  s.summary          = 'NFC Forum Well Known Type Data Parser for iOS11 and Core NFC'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

NFC Forum Well Known Type Data Parser for iOS11 and Core NFC.
Supports parsing of types:
Text - NFCForum-TS-RTD_Text_1.0 2006-07-24
Uri - NFCForum-TS-RTD_URI_1.0 2006-07-24
Smart Poster - NFCForum-SmartPoster_RTD_1.0 2006-07-24

DESC

  s.homepage         = 'https://github.com/jvk75/NFCNDEFParse'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jari Kalinainen' => 'jari@klubitii.com' }
  s.source           = { :git => 'https://github.com/jvk75/NFCNDEFParse.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'NFCNDEFParse/*'
  
end
