require "test_helper"

class CookieControllerTest < ActionDispatch::IntegrationTest
  test "read plain cookies" do
    get "/cookie", params: { cookies: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar[:coffee]
  end

  test "read encrypted cookies" do
    get "/cookie", params: { encrypted: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.encrypted[:coffee]
  end

  test "read signed cookies" do
    get "/cookie", params: { signed: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.signed[:coffee]
  end

  test "set plain cookies" do
    cookies_jar[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("cookie", "coffee")
  end

  test "set encrypted cookies" do
    cookies_jar.encrypted[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("encrypted", "coffee")
  end

  test "set signed cookies" do
    cookies_jar.signed[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("signed", "coffee")
  end
end
