Pod::Spec.new do |s|
    s.name         = 'WLCKit'
    s.version      = '1.7'
    s.summary      = 'An library including fundation classes and categories'
    s.homepage     = 'https://github.com/wanglichun'
    s.license      = 'MIT'
    s.authors      = {'wanglichun' => 'wlccqu@126.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/wanglichun/WLCKit', :tag => '1.1'}
    s.source_files = 'WLCKit/Classes/*.{h,m}', 'WLCKit/Categories/*.{h,m}', 'WLCKit/WLCKit.h'
    # s.public_header_files = 'WLCKit/WLCKit.h'
    # s.prefix_header_file = 'WLCKit/WLCKitPrefixHeader.pch'
    s.resources    = "WLCKit/WLCKitBundle.bundle"
    s.requires_arc = true
    s.frameworks = 'UIKit'
end
