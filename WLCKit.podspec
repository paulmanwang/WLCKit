Pod::Spec.new do |s|
    s.name         = 'WLCKit'
    s.version      = '1.6'
    s.summary      = 'An library including fundation classes and categories'
    s.homepage     = 'https://git.coding.net/wanglichun/WLCKit.git'
    s.license      = 'MIT'
    s.authors      = {'wanglichun' => 'wlccqu@126.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://git.coding.net/wanglichun/WLCKit.git', :tag => '1.6'}
    s.source_files = 'WLCKit/Classes/*.{h,m}', 'WLCKit/Categories/*.{h,m}', 'WLCKit/WLCKit.h'
    # s.public_header_files = 'WLCKit/WLCKit.h'
    # s.prefix_header_file = 'WLCKit/WLCKitPrefixHeader.pch'
    s.resources    = "WLCKit/WLCKitBundle.bundle"
    s.requires_arc = true
    s.frameworks = 'UIKit'
end
