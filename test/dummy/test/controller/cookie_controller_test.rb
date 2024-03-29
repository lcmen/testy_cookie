require "test_helper"

class CookieControllerTest < ActionController::TestCase
  test "read plain cookies" do
    get :show, params: {cookies: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar[:coffee]
  end

  test "read encrypted cookies" do
    get :show, params: {encrypted: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.encrypted[:coffee]
  end

  test "read permanent cookies" do
    get :show, params: {permanent: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.permanent[:coffee]
  end

  test "read signed cookies" do
    get :show, params: {signed: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.signed[:coffee]
  end

  test "set plain cookies" do
    cookie_jar[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("cookie", "coffee")
  end

  test "set encrypted cookies" do
    cookie_jar.encrypted[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("encrypted", "coffee")
  end

  test "set permanent cookies" do
    cookie_jar.permanent[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("permanent", "coffee")
  end

  test "set signed cookies" do
    cookie_jar.signed[:coffee] = "black"
    get :show
    assert_response :success
    assert_equal "black", response.parsed_body.dig("signed", "coffee")
  end

  test "read and set combined cookie_jar" do
    cookie_jar.signed.encrypted[:coffee] = "black"

    get :show, params: {signed_and_encrypted: {ice_cream: "vanilla"}}
    assert_response :success

    assert_equal "black", cookie_jar.signed.encrypted[:coffee]
    assert_equal "vanilla", cookie_jar.signed.encrypted[:ice_cream]
  end
end
