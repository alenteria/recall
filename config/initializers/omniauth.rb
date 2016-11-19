Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Recall::FACEBOOK_KEY, Recall::FACEBOOK_SECRET,
    scope: 'email,user_birthday,public_profile',
    callback_url: "http://#{Recall::DOMAIN}/users/auth/facebook/callback"
end