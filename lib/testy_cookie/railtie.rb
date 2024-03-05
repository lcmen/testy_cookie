module TestyCookie
  class Railtie < ::Rails::Railtie
    initializer "testy_cookie.add_helpers" do
      ActiveSupport::TestCase.send(:include, TestyCookie::Helper)

      if defined?(RSpec) && RSpec.respond_to?(:configure)
        RSpec.configure do |config|
          config.include TestyCookie::Helper, type: :controller
          config.include TestyCookie::Helper, type: :request
        end
      end
    end

    initializer "testy_cookie.deprecator" do |app|
      app.deprecators[:testy_cookie] = DEPRECATOR
    end
  end
end
