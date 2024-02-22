module TestyCookie
  class Jar
    # @param context [ActionController::TestCase, ActionDispatch::IntegrationTest, RSpec::ExampleGroup] the test context
    def initialize(context)
      @context = context
    end

    # @return [ActionDispatch::Cookies::CookieJar] the cookie jar to use
    def cookies
      if @context.cookies.is_a?(ActionDispatch::Cookies::CookieJar)
        @context.cookies
      else
        Proxy.new(response_cookies || request_cookies, @context.cookies, nil)
      end
    end

    private

    def request
      # Memoize the request object until the next request is made and cookies jar needs to be reevaluated
      if @request != @context.request
        @request = @context.request
        @request_cookies = nil
      end

      @request
    end

    def request_cookies
      @request_cookies ||= ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    end

    def response
      # Memoize the response object until the next request is made and cookies jar needs to be reevaluated
      if @response != @context.response
        @response = @context.response
        @response_cookies = nil
      end

      @response
    end

    def response_cookies
      return unless response.present?
      # We need to check for `path_parameters` in request because controller tests initialize
      # request and response objects before the actual controller action is called.
      return unless request&.path_parameters.present?

      @response_cookies ||= ActionDispatch::Cookies::CookieJar.build(request, @context.cookies.to_hash)
    end
  end
end
