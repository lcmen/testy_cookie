require "test_helper"

class DummyClass
  include TestyCookie::Helper

  def cookies
    {}
  end

  def response
    nil
  end
end

class TestyCookie::HelperTest < ActiveSupport::TestCase
  test "cookie_jar" do
    dummy = DummyClass.new
    assert_instance_of TestyCookie::Proxy, dummy.cookie_jar
  end

  test "cookies_jar" do
    dummy = DummyClass.new

    assert_deprecated(/cookies_jar/, TestyCookie::DEPRECATOR) do
      assert_instance_of TestyCookie::Proxy, dummy.cookies_jar
    end
  end
end
