# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
  pod 'SVProgressHUD'
  pod 'Simple-Networking', '~> 0.3.2'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'Kingfisher', '~> 5.0'
end

target 'MobilPelisProd' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MobilPelis
  shared_pods

end

target 'MobilPelisDev' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MobilPelis
  shared_pods

  target 'MobilPelisTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MobilPelisUITests' do
    # Pods for testing
  end

end
