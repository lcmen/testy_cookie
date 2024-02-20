module TestyJar
  module Helper
    def cookies_jar
      @cookies_jar ||= Store.new(cookies, request:, response:)
    end
  end
end
