require "testy_cookie/helper"
require "testy_cookie/jar"
require "testy_cookie/proxy"
require "testy_cookie/railtie"
require "testy_cookie/version"

module TestyCookie
  DEPRECATOR = ActiveSupport::Deprecation.new("2.0", "TestyCookie")
end
