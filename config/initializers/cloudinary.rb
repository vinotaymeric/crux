Cloudinary.config do |config|
  config.cloud_name = 'dbehokgcg'
  config.api_key = ENV['API_KEY_CLOUDINARY']
  config.api_secret = ENV['API_SECRETE_CLOUDINARY']
  config.secure = true
  config.cdn_subdomain = true
end
