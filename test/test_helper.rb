# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)

class ActiveSupport::TestCase
  fixtures :all

  def items(key)
    item = gnoibox_items(key)
    Gnoibox::BoxCollection.find(item.box_key).find_item item.url
  end
  
  def items_with_tag(key)
    items(key).tap do |i|
      i.set_tags_from_content
      i.save
    end
  end
end
