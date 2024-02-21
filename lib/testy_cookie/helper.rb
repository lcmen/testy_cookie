module TestyCookie
  module Helper
    def cookies_jar
      @cookies_jar ||= Jar.new(self)
      @cookies_jar.cookies
    end
  end
end
