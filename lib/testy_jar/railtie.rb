module TestyJar
  class Railtie < ::Rails::Railtie
    initializer "testy_jar.add_helpers" do
      ActiveSupport::TestCase.send(:include, TestyJar::Helper)
      RSpec.configure do |config|
        config.include TestyJar::Helper, type: :controller
        config.include TestyJar::Helper, type: :request
      end
    end
  end
end
