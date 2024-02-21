require "test_helper"

class CookieControllerTest < ActionController::TestCase
  test "read plain cookies" do
    get :show, params: { cookies: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.plain[:coffee]
  end

  test "read encrypted cookies" do
    get :show, params: { encrypted: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.encrypted[:coffee]
  end

  test "read permanent cookies" do
    get :show, params: { permanent: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.permanent[:coffee]
  end

  test "read signed cookies" do
    get :show, params: { signed: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.signed[:coffee]
  end

  test "set plain cookies" do
    cookies_jar.plain[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("cookie", "coffee")
  end

  test "set encrypted cookies" do
    cookies_jar.encrypted[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("encrypted", "coffee")
  end

  test "set permanent cookies" do
    cookies_jar.permanent[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("permanent", "coffee")
  end

  test "set signed cookies" do
    cookies_jar.signed[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("signed", "coffee")
  end
end
