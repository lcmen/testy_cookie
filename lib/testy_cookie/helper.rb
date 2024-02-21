module TestyCookie
  module Helper
    def cookies_jar
      @cookies_jar ||= Store.new(self)
    end
  end
end
