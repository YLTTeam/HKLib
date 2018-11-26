
Pod::Spec.new do |s|
  s.name             = 'HKLib'
  s.version          = '0.0.1'
  s.summary          = '黑卡业务库'

  s.description      = <<-DESC
从黑卡App中抽离的部分业务库
                       DESC

  s.homepage         = 'https://github.com/YLTTeam/HKLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xphaijj0305@126.com' => 'xianggong@anve.com' }
  s.source           = { :git => 'https://github.com/YLTTeam/HKLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HKLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HKLib' => ['HKLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YLT_Kit'
  s.dependency 'TTTAttributedLabel'
  s.dependency 'pop'
end
