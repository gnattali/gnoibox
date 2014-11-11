Devise.setup do |config|
  config.router_name = :gnoibox
  
  config.sign_out_via = :delete

  require 'devise/orm/active_record'
end
