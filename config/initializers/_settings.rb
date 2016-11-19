module Recall
  def self.env
    defined?(Rails) ? Rails.env : ENV['RACK_ENV']
  end
end

# == Facebook ======================================================
if Recall.env.production?
  Recall::FACEBOOK_KEY = ENV['FACEBOOK_KEY']
  Recall::FACEBOOK_SECRET = ENV['FACEBOOK_SECRET']
else
  Recall::FACEBOOK_KEY = '325403197846567'
  Recall::FACEBOOK_SECRET = 'fbc814e32ec6c67b28fae6fc5544c407'
end

# == Domain =======================================================
if Recall.env.production?
  Recall::DOMAIN = 'Recall.com'
else
  Recall::DOMAIN = 'localhost:3000'
end


# == SINCH ========================================================
Recall::SINCH_APPLICATION_KEY = 'a19f7b1b-7283-48da-b79d-3c6736cc1562'