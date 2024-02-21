require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
#   if Rails.env.production? # 本番環境の場合はS3へアップロード
#     config.storage :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_directory  = 'graduation-goods-bucket' # バケット名
#     config.fog_public = false
#     config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/graduation-goods-bucket'
#     config.fog_credentials = {
#       provider: 'AWS',
#       access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#       secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#       region: 'ap-northeast-1', # リージョン
#       # path_style: true
#     }
#   else # 本番環境以外の場合はアプリケーション内にアップロード
#     config.storage :file
#     config.enable_processing = false if Rails.env.test?
#   end
# end

# CarrierWave.configure do |config|
#   config.storage :fog
#   config.fog_provider = 'fog/aws'
#   config.fog_directory  = 'graduation-goods-bucket' # バケット名
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], # 環境変数
#     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # 環境変数
#     region: 'ap-northeast-1', # リージョン
#     path_style: true
#   }
# end 

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'graduation-goods-bucket'
    config.asset_host = 'https://s3.amazonaws.com/graduation-goods-bucket'
    # NOTE: AWS側の設定を変えなくても、この１行の設定でアップロードできた
    config.fog_public = false # ←コレ
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1',
      # path_style: true
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end