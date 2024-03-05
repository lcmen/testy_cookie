require "test_helper"

class DummyContext
  include TestyCookie::Helper

  def cookies
    {}
  end

  def response
    nil
  end
end

class TestyCookie::HelperTest < ActiveSupport::TestCase
  setup do
    @context = DummyContext.new
  end

  test "cookie_jar" do
    assert_instance_of TestyCookie::Proxy, @context.cookie_jar
  end

  test "cookies_jar" do
    assert_deprecated(/cookies_jar/, TestyCookie::DEPRECATOR) do
      assert_instance_of TestyCookie::Proxy, @context.cookies_jar
    end
  end
end
