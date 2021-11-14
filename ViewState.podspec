#
# Be sure to run `pod lib lint ViewState.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewState'
  s.version          = '1.2.1'
  s.summary          = 'Adds an ability to check a view controller\'s view state.'

  s.description      = <<-DESC
Adds an ability to check a view controller's view state and also to subscribe to view state changes notifications. Also, adds several helpful properties to easily configure some complex behaviors in xibs and storyboards.
                       DESC

  s.homepage         = 'https://github.com/APUtils/ViewState'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Plebanovich' => 'anton.plebanovich@gmail.com' }
  s.source           = { :git => 'https://github.com/APUtils/ViewState.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.swift_versions = ['5.1']
  s.frameworks = 'Foundation', 'UIKit'
  s.dependency 'RoutableLogger', '>= 9.1.11'
  s.source_files = 'ViewState/Classes/**/*'
end
