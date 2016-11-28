module Recall
  def self.env
    defined?(Rails) ? Rails.env : ENV['RACK_ENV']
  end
end

# == Facebook ======================================================
if Recall.env.production?
  Recall::FACEBOOK_KEY = ENV['FACEBOOK_KEY'] || '1257826974275770'
  Recall::FACEBOOK_SECRET = ENV['FACEBOOK_SECRET'] || '0d2ce18a911069728353ca06a889b4ef'
else
  Recall::FACEBOOK_KEY = '325403197846567'
  Recall::FACEBOOK_SECRET = 'fbc814e32ec6c67b28fae6fc5544c407'
end

# == Domain =======================================================
if Recall.env.production?
  Recall::DOMAIN = 'recool.herokuapp.com'
else
  Recall::DOMAIN = 'localhost:3000'
end


# == SINCH ========================================================
# sandbox
Recall::SINCH_APPLICATION_KEY = '3d18e22e-f376-44cb-bdbe-3e06988e0739'
Recall::SINCH_APPLICATION_SECRET = 'DeC93fnETUem6NUpW36pAg=='

# production
# Recall::SINCH_APPLICATION_KEY = '9f34714f-a63c-4409-accc-12d24eeea8d9'
# Recall::SINCH_APPLICATION_SECRET = '2weEIwJO3USgUcwD45gMTg=='