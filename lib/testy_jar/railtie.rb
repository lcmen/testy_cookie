module TestyJar
  class Railtie < ::Rails::Railtie
    initializer "testy_jar.add_helpers" do
      ActiveSupport::TestCase.send(:include, TestyJar::Helper)

      if defined?(RSpec) && RSpec.respond_to?(:configure)
        RSpec.configure do |config|
          config.include TestyJar::Helper, type: :controller
          config.include TestyJar::Helper, type: :request
        end
      end
    end
  end
end
