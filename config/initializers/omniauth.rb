OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['OMNIAUTH_FB_ID'], ENV['OMNIAUTH_FB_KEY']
end