module TestyJar
  class Store
    class Proxy < SimpleDelegator
      def initialize(jar, store, cookies, read_only)
        super(store)
        @jar = jar
        @cookies = cookies
        @read_only = read_only
      end

      def []=(key, value)
        raise(ArgumentError, "Cannot write to cookies as the response has already been sent") if @read_only

        super
        @cookies[key] = @jar[key]
      end
    end

    delegate :[], to: :jar

    def initialize(cookies, request:, response:)
      @cookies = cookies
      @request = request
      @response = response
    end

    def []=(key, value)
      raise(ArgumentError, "Cannot write to cookies as the response has already been sent") if read_only?

      jar[key] = value
      @cookies[key] = value
    end

    def encrypted
      @encrypted ||= Proxy.new(jar, jar.encrypted, @cookies, read_only?)
    end

    def signed
      @signed ||= Proxy.new(jar, jar.signed, @cookies, read_only?)
    end

    private

    def jar
      @jar ||= response_cookies || request_cookies
    end

    def read_only?
      @response.present?
    end

    def request_cookies
      ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    end

    def response_cookies
      return unless @response

      ActionDispatch::Cookies::CookieJar.build(@request, @response.cookies)
    end
  end
end
