#
# Be sure to run `pod lib lint VisionUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'VisionUIKit'
    s.version          = '0.1.32'
    s.summary          = '定制化的UI控件'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    定制化的UI控件
                       DESC

    s.homepage         = 'https://github.com/cheneylew/VisionUIKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Deju Liu' => 'cheneylew@163.com' }
    s.source           = { :git => 'https://github.com/cheneylew/VisionUIKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files = 'VisionUIKit/Classes/**/*'

    s.subspec 'UIKit' do |sp|
        sp.requires_arc        = true
        sp.subspec 'TextField' do |spp|
            spp.requires_arc        = true
            spp.source_files = 'VisionUIKit/Classes/UIKit/TextField/**/*'
        end
        sp.subspec 'AlertView' do |spp|
            spp.requires_arc        = true
            spp.source_files = 'VisionUIKit/Classes/UIKit/AlertView/**/*'
        end
        sp.subspec 'TableView' do |spp|
            spp.requires_arc        = true
            spp.source_files = 'VisionUIKit/Classes/UIKit/TableView/**/*'
            spp.dependency 'VisionUIKit/UIKit/TextField'
        end
    end

    s.subspec 'Config' do |sp|
        sp.requires_arc        = true
        sp.source_files = 'VisionUIKit/Classes/Config/**/*'
    end

    s.subspec 'Core' do |sp|
        sp.requires_arc        = true
        sp.source_files = 'VisionUIKit/Classes/Core/**/*'
        sp.dependency 'VisionUIKit/Config'
    end

    # s.resource_bundles = {
    #   'VisionUIKit' => ['VisionUIKit/Assets/*.png']
    # }
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'KKCategories', '~> 0.3.7'
    s.dependency 'DJMacros', '~> 0.7.12'
    s.dependency 'JHChainableAnimations', '~> 1.3.0'
    s.dependency 'ReactiveCocoa', '~> 2.5'
    s.dependency 'AFNetworking', '~> 3.1.0'
end
