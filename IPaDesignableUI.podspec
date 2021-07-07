#
# Be sure to run `pod lib lint IPaDesignableUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IPaDesignableUI'
  s.version          = '4.1'
  s.summary          = 'A short description of IPaDesignableUI.'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ipapamagic/IPaDesignableUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ipapamagic@gmail.com' => 'ipapamagic@gmail.com' }
  s.source           = { :git => 'https://github.com/ipapamagic/IPaDesignableUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  # s.source_files = 'IPaDesignableUI/Classes/**/*'
  s.swift_version = '5.3'
  # s.resource_bundles = {
  #   'IPaDesignableUI' => ['IPaDesignableUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'IPaUIKitHelper', '~> 1.0'
  s.dependency 'IPaLog', '~> 3.0'
  s.subspec 'IPaDesignable' do |sp|
    sp.source_files = 'IPaDesignableUI/Classes/IPaDesignable/*'
    
  end
  s.subspec 'IPaFitContent' do |sp|
    sp.source_files = 'IPaDesignableUI/Classes/IPaFitContent/*'
    sp.dependency 'IPaDesignableUI/IPaDesignable'
  end
  s.subspec 'IPaImageURL' do |sp|
    sp.source_files = 'IPaDesignableUI/Classes/IPaImageURL/*'
    sp.dependency 'IPaDesignableUI/IPaDesignable'
    s.dependency 'IPaDownloadManager', '~> 1.3'
    s.dependency 'IPaImageTool', '~> 2.3'
    s.dependency 'IPaFileCache', '~> 1.0'
  end
  s.subspec 'IPaNestedScrollView' do |sp|
    sp.source_files = 'IPaDesignableUI/Classes/IPaNestedScrollView/*'
    sp.dependency 'IPaDesignableUI/IPaDesignable'
  end
  s.subspec 'IPaStyleButton' do |sp|
    sp.source_files = 'IPaDesignableUI/Classes/IPaStyleButton/*'
    sp.dependency 'IPaDesignableUI/IPaDesignable'
  end
  
end
