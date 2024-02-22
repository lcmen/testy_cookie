module TestyCookie
  # Proxy for propagating cookie changes to `Rack::Test::CookieJar`
  class Proxy < SimpleDelegator
    # @param cookies [ActionDispatch::Cookies::CookieJar] the cookie jar to delegate to
    # @param raw_cookies [Rack::Test::CookieJar] the cookies to propagate changes to
    # @param parent [Proxy, nil] the parent proxy to chain cookie operations
    def initialize(cookies, raw_cookies, parent)
      super(cookies)
      @parent = parent
      @raw_cookies = raw_cookies
    end

    # @param key [String] the cookie key
    # @param value [String] the cookie value
    def []=(key, value)
      super
      assign(key)
    end

    # @return [Proxy] proxy to the encrypted cookie jar
    def encrypted
      self.class.new(__getobj__.encrypted, @raw_cookies, self)
    end

    # @return [Proxy] proxy to the permanent cookie jar
    def permanent
      self.class.new(__getobj__.permanent, @raw_cookies, self)
    end

    # @return [Proxy] proxy the signed cookie jar
    def signed
      self.class.new(__getobj__.signed, @raw_cookies, self)
    end

    protected

    def assign(key)
      if @parent.present?
        @parent.assign(key)
      else
        @raw_cookies[key] = __getobj__[key]
      end
    end
  end
end
