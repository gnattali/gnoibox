Devise.setup do |config|
  config.router_name = :gnoibox

  require 'devise/orm/active_record'
end
