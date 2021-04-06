#
# Be sure to run `pod lib lint CellDataCoupler.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CellDataCoupler'
  s.version          = '3.1.1'
  s.summary          = 'CellDataCoupler is a pod that abstracts away a lot of the logic involved in creating a viable table datasource.'


s.description      = <<-DESC
We wanted to simplify tableviews. CellDataCoupler is a pod that abstracts away a lot of the logic involved in creating a viable table datasource. It provides a default implementation that you can either use or override.
DESC

  s.homepage         = 'https://github.com/myriadmobile/CellDataCoupler'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alex Larson' => 'alarson@myriadmobile.com' }
  s.source           = { :git => 'https://github.com/myriadmobile/CellDataCoupler.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'

  s.source_files = 'CellDataCoupler/Classes/**/*.{swift,h,m}'
  s.resources = 'CellDataCoupler/Classes/**/*.{xib,storyboard,png,jpeg,jpg,txt,ttf,xcassets}'
end
