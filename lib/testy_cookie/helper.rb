module TestyCookie
  module Helper
    def cookie_jar
      @_testy_cookie_cookie_jar ||= Jar.new(self)
      @_testy_cookie_cookie_jar.cookies
    end

    def cookies_jar
      DEPRECATOR.warn(<<~MSG.squish.freeze)
        `cookies_jar` is deprecated and will be removed in the next major version. Please use `cookie_jar` instead.
      MSG

      cookie_jar
    end
  end
end
