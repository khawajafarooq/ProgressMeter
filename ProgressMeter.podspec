Pod::Spec.new do |s|
  s.name             = 'ProgressMeter'
  s.version          = '0.1.3'
  s.summary          = 'Measuring the progress is not a problem anymore 😎'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ProgressMeter displays the progress in a meter with the custom annotations. So, it's not only the progress bar with its usual functionality, but also gives the better visual when chasing a target. 💯
Don't have data? No problem, ProgressMeter comes with it's own data set.
                       DESC

  s.homepage         = 'https://github.com/khawajafarooq/ProgressMeter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'khawajafarooq' => 'kfarooqa@gmail.com' }
  s.source           = { :git => 'https://github.com/khawajafarooq/ProgressMeter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/khfarooq'
  s.ios.deployment_target = '9.0'
  s.source_files = 'ProgressMeter/Classes/**/*.swift'

end
