#
# Be sure to run `pod lib lint ViewState.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewState'
  s.version          = '2.0.0'
  s.summary          = 'Adds an ability to check a view controller\'s view state.'

  s.description      = <<-DESC
Adds an ability to check a view controller's view state and also to subscribe to view state changes notifications. Also, adds several helpful properties to easily configure some complex behaviors in xibs and storyboards.
                       DESC

  s.homepage         = 'https://github.com/APUtils/ViewState'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Plebanovich' => 'anton.plebanovich@gmail.com' }
  s.source           = { :git => 'https://github.com/APUtils/ViewState.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  s.swift_versions = ['5.5', '5.5.1', '5.5.2', '5.6', '5.6.1', '5.7']
  s.frameworks = 'Foundation', 'UIKit'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |subspec|
      subspec.source_files = 'ViewState/Classes/Core/**/*'
      subspec.dependency 'RoutableLogger', '>= 9.1.11'
  end
  
  s.subspec 'RxSwift' do |subspec|
      subspec.source_files = 'ViewState/Classes/RxSwift/**/*'
      subspec.dependency 'ViewState/Core'
      subspec.dependency 'RxCocoa'
      subspec.dependency 'RxSwift'
  end
  
end
