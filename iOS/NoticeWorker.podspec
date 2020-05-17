#
#  Be sure to run `pod spec lint NoticeWorker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "NoticeWorker"
  spec.version      = "0.7.0"
  spec.summary      = "Notice Parser for Mobile Platform"
  spec.description  = <<-DESC
We provide URL constants and parsing modules that can provide school notices."
	 	      DESC

  spec.homepage     = "https://github.com/della-padula/NoticeWorker"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { 'Taein Kim' => 'della.kimko@gmail.com' }

  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'

  spec.source       = { :git => "https://github.com/della-padula/NoticeWorker.git", :tag => spec.version.to_s }

  spec.source_files  = "NoticeWorker/**/**/**/*.swift"
  spec.swift_version = '5.1'

end
