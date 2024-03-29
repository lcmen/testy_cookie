require "test_helper"

class CookieTest < ActionDispatch::IntegrationTest
  test "read plain cookies" do
    get "/cookie", params: {cookies: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar[:coffee]
  end

  test "read encrypted cookies" do
    get "/cookie", params: {encrypted: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.encrypted[:coffee]
  end

  test "read permanent cookies" do
    get "/cookie", params: {permanent: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.permanent[:coffee]
  end

  test "read signed cookies" do
    get "/cookie", params: {signed: {coffee: "black"}}
    assert_response :success
    assert_equal "black", cookie_jar.signed[:coffee]
  end

  test "set plain cookies" do
    cookie_jar[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("cookie", "coffee")
  end

  test "set encrypted cookies" do
    cookie_jar.encrypted[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("encrypted", "coffee")
  end

  test "set permanent cookies" do
    cookie_jar.permanent[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("permanent", "coffee")
  end

  test "set signed cookies" do
    cookie_jar.signed[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("signed", "coffee")
  end

  test "read and set cookies on multiple requests" do
    cookie_jar[:coffee] = "black"
    cookie_jar.encrypted[:additive] = "sugar"
    cookie_jar.permanent[:milk] = "soy"

    get "/cookie", params: {cookies: {sandwich: "tuna"}, signed: {fruit: "apple"}, permanent: {juice: "orange"}}
    assert_response :success

    assert_equal "black", cookie_jar[:coffee]
    assert_equal "tuna", cookie_jar[:sandwich]
    assert_equal "sugar", cookie_jar.encrypted[:additive]
    assert_equal "soy", cookie_jar.permanent[:milk]
    assert_equal "orange", cookie_jar.permanent[:juice]
    assert_equal "apple", cookie_jar.signed[:fruit]

    get "/cookie", params: {encrypted: {cake: "chocolate"}, permanent: {ice_cream: "vanilla"}}

    assert_equal "black", cookie_jar[:coffee]
    assert_equal "tuna", cookie_jar[:sandwich]
    assert_equal "sugar", cookie_jar.encrypted[:additive]
    assert_equal "chocolate", cookie_jar.encrypted[:cake]
    assert_equal "soy", cookie_jar.permanent[:milk]
    assert_equal "vanilla", cookie_jar.permanent[:ice_cream]
    assert_equal "orange", cookie_jar.permanent[:juice]
    assert_equal "apple", cookie_jar.signed[:fruit]
  end

  test "read and set combined cookie_jar" do
    cookie_jar.signed.encrypted[:coffee] = "black"

    get "/cookie", params: {signed_and_encrypted: {ice_cream: "vanilla"}}
    assert_response :success

    assert_equal "black", cookie_jar.signed.encrypted[:coffee]
    assert_equal "vanilla", cookie_jar.signed.encrypted[:ice_cream]
  end
end
