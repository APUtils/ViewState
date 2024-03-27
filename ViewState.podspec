#
# Be sure to run `pod lib lint ViewState.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewState'
  s.version          = '2.1.0'
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
  s.frameworks = 'Foundation', 'UIKit'
  s.swift_versions = ['5']
  
  # 1.12.0: Ensure developers won't hit CocoaPods/CocoaPods#11402 with the resource
  # bundle for the privacy manifest.
  # 1.13.0: visionOS is recognized as a platform.
  s.cocoapods_version = '>= 1.13.0'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |subspec|
      subspec.source_files = 'ViewState/Classes/Core/**/*'
      subspec.resource_bundle = {"ViewState.Core.privacy"=>"ViewState/Privacy/ViewState.Core/PrivacyInfo.xcprivacy"}
      subspec.dependency 'RoutableLogger', '>= 9.1.11'
  end
  
  s.subspec 'RxSwift' do |subspec|
      subspec.source_files = 'ViewState/Classes/RxSwift/**/*'
      subspec.resource_bundle = {"ViewState.RxSwift.privacy"=>"ViewState/Privacy/ViewState.RxSwift/PrivacyInfo.xcprivacy"}
      subspec.dependency 'ViewState/Core'
      subspec.dependency 'RxCocoa'
      subspec.dependency 'RxSwift'
  end
  
end
