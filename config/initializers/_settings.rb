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
Recall::SINCH_APPLICATION_KEY = '53e09f7c-1070-4504-bf17-72f2f2d32572'
Recall::SINCH_APPLICATION_SECRET = 'i7ovcaLg40qSeT71zVbvCQ=='

# sandbox2
# Recall::SINCH_APPLICATION_KEY = '7ea14a09-2462-4d5c-a561-9441606a18cc'
# Recall::SINCH_APPLICATION_SECRET = 'IXfJffK67Euv25oJnwZWsQ=='

# production
# Recall::SINCH_APPLICATION_KEY = '9f34714f-a63c-4409-accc-12d24eeea8d9'
# Recall::SINCH_APPLICATION_SECRET = '2weEIwJO3USgUcwD45gMTg=='

# production2
# Recall::SINCH_APPLICATION_KEY = '8408c8bc-349d-4d50-9705-59a029c52d7e'
# Recall::SINCH_APPLICATION_SECRET = '+qehb5Z4pUSUxvbYmFcMDA=='