module TestyJar
  class Store
    class Proxy < SimpleDelegator
      def initialize(jar, store, cookies)
        super(store)
        @jar = jar
        @cookies = cookies
      end

      def []=(key, value)
        super
        @cookies[key] = @jar[key] if @cookies
      end
    end

    delegate :cookies, to: :@context

    def initialize(context)
      @context = context
    end

    def encrypted
      Proxy.new(jar, jar.encrypted, cookies)
    end

    def permanent
      Proxy.new(jar, jar.permanent, cookies)
    end

    def plain
      Proxy.new(jar, cookies, nil)
    end

    def signed
      Proxy.new(jar, jar.signed, cookies)
    end

    private

    def jar
      response_cookies || request_cookies
    end

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

      @response_cookies ||= ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
    end
  end
end
