Pod::Spec.new do |s|

  s.name             = 'FiveUtils'
  s.version          = '1.0.0'
  s.summary          = 'Five\'s commonly used iOS utility modules.'

  s.description      = <<-DESC
    A collection of various math extensions, random generators and other utility modules we tend to re-use on
    our projects at Five (http://five.agency).
                       DESC

  s.homepage         = 'https://github.com/fiveagency/ios-five-utils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iOS libraries team' => 'ios.libraries@five.agency' }
  s.source           = { :git => 'https://github.com/fiveagency/ios-five-utils.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'FiveUtils/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

end
