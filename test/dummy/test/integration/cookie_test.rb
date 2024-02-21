require "test_helper"

class CookieTest < ActionDispatch::IntegrationTest
  test "read plain cookies" do
    get "/cookie", params: { cookies: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.plain[:coffee]
  end

  test "read encrypted cookies" do
    get "/cookie", params: { encrypted: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.encrypted[:coffee]
  end

  test "read permanent cookies" do
    get "/cookie", params: { permanent: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.permanent[:coffee]
  end

  test "read signed cookies" do
    get "/cookie", params: { signed: { coffee: "black" } }
    assert_response :success
    assert_equal "black", cookies_jar.signed[:coffee]
  end

  test "set plain cookies" do
    cookies_jar.plain[:coffee] = "black"
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

  test "set permanent cookies" do
    cookies_jar.permanent[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("permanent", "coffee")
  end

  test "set signed cookies" do
    cookies_jar.signed[:coffee] = "black"
    get "/cookie"
    assert_response :success
    assert_equal "black", response.parsed_body.dig("signed", "coffee")
  end

  test "reading and setting cookies on multiple requests" do
    cookies_jar.plain[:coffee] = "black"
    cookies_jar.encrypted[:additive] = "sugar"
    cookies_jar.permanent[:milk] = "soy"

    get "/cookie", params: { cookies: { sandwich: "tuna" }, signed: { fruit: "apple" }, permanent: { juice: "orange" } }
    assert_response :success

    assert_equal "black", cookies_jar.plain[:coffee]
    assert_equal "tuna", cookies_jar.plain[:sandwich]
    assert_equal "sugar", cookies_jar.encrypted[:additive]
    assert_equal "soy", cookies_jar.permanent[:milk]
    assert_equal "orange", cookies_jar.permanent[:juice]
    assert_equal "apple", cookies_jar.signed[:fruit]

    get "/cookie", params: { encrypted: { cake: "chocolate" }, permanent: { ice_cream: "vanilla" } }

    assert_equal "black", cookies_jar.plain[:coffee]
    assert_equal "tuna", cookies_jar.plain[:sandwich]
    assert_equal "sugar", cookies_jar.encrypted[:additive]
    assert_equal "chocolate", cookies_jar.encrypted[:cake]
    assert_equal "soy", cookies_jar.permanent[:milk]
    assert_equal "vanilla", cookies_jar.permanent[:ice_cream]
    assert_equal "orange", cookies_jar.permanent[:juice]
    assert_equal "apple", cookies_jar.signed[:fruit]
  end
end
