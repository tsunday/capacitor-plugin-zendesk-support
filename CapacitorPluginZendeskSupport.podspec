require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'CapacitorPluginZendeskSupport'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = package['repository']['url']
  s.author = package['author']
  s.source = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target  = '12.0'
  s.dependency 'Capacitor'
  s.dependency 'ZendeskSupportSDK'
  s.dependency 'ZendeskAnswerBotSDK' # AnswerBot-only on the Unified SDK
  s.dependency 'ZendeskChatSDK' 
  s.source = { :git => 'https://github.com/zendesk/support_sdk_ios'}
  s.swift_version = '5.1'
end
