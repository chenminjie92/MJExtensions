#
# Be sure to run `pod lib lint MJExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name              = "MJExtensions"
  spec.version           = '1.0.0'
  spec.swift_versions    = '5.0'
  spec.license           = { :type => 'MIT', :text => <<-LICENSE
                              Copyright 2019
                              LICENSE
                            }
  spec.summary           = "一些常用的扩展"
  spec.description       = <<-DESC
                            一些常用的扩展
                            DESC
  spec.homepage          = 'https://github.com/chenminjie92/MJExtensions'
  spec.author            = { "chenminjie" => "chenminjie92@126.com" }

  spec.source            = { :git => 'https://github.com/chenminjie92/MJExtensions.git', :tag => "#{spec.version}" }
  spec.platform          = :ios, "10.0"
  spec.static_framework  = true

  spec.source_files      = 'MJExtensions/**/*.{h,m,swift}'
  #图片加载
  spec.dependency     'Kingfisher'
  #导航栏
  spec.dependency     'RTRootNavigationController'
  spec.dependency     'CryptoSwift'
  spec.dependency     'Schedule'
  spec.dependency     'MBProgressHUD'
  spec.dependency     'MJRefresh'
  spec.dependency     'RxSwift'
end
