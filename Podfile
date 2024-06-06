
platform :ios, '12.0'
source 'https://github.com/CocoaPods/Specs.git'
target 'cjjc_viper_cjjc' do
  
# Swift
pod 'Kingfisher'
pod "KingfisherWebP"
pod 'SnapKit'
pod 'SwiftyJSON'
pod 'IQKeyboardManagerSwift'
pod 'Alamofire'
pod 'SwiftyUserDefaults'
pod 'HandyJSON'
pod 'SwiftyAttributes'
pod 'Gifu'
pod 'CryptoSwift'
pod 'FSPagerView'
pod 'Localize-Swift'
pod 'ZLPhotoBrowser'
pod 'R.swift'
pod 'SkeletonView'
#pod "Ipify"
pod 'DeviceKit', '~> 4.0'
pod 'SwiftPublicIP', '~> 0.0.2'
#pod 'Cache'
#pod 'DaisyNet','1.0.5'
# pod 'PromiseKit'

#pod 'RxSwift'
#pod 'RxCocoa'
#pod 'Moya/RxSwift'
#pod 'TextFieldEffects'
pod 'SwiftyDrop'
pod 'SwiftMessages'
pod 'KeenCodeUnit'


# OC
pod 'FDFullscreenPopGesture'
pod 'MBProgressHUD'
#pod 'TZImagePickerController'
pod 'MJRefresh'
pod 'YBPopupMenu'
pod 'SocketRocket'
#pod 'Bugly'



#pod 'JPush'
#pod 'CRBoxInputView'
#pod 'HCSStarRatingView'
#pod 'SDCycleScrollView'

#pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull'

#pod 'UMengUShare/Social/WeChat'
#pod 'UMengUShare/UI'
#pod 'UMCCommon'
#pod 'UMCCommonLog'
#pod 'UMCAnalytics'
inhibit_all_warnings!

use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
end

