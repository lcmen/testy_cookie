require "test_helper"

class Chained < Hash
  def self.build
    new(nil)
  end

  def initialize(prefix, *args)
    @prefix = "#{prefix}_"
    super(*args)
  end

  def []=(key, value)
    super(key, "#{@prefix}#{value}")
  end

  %i[encrypted permanent signed].each do |method|
    define_method(method) do
      instance_variable_get(:"@#{method}") || instance_variable_set(:"@#{method}", Chained.new("#{@prefix}#{method}", self))
    end
  end
end

class TestyCookie::ProxyTest < ActiveSupport::TestCase
  setup do
    @cookies = {}
    @proxy = TestyCookie::Proxy.new(Chained.build, @cookies, nil)
  end

  test "reading and writing plain text values" do
    @proxy[:coffee] = "black"
    assert_equal "_black", @proxy[:coffee]
    assert_equal "_black", @cookies[:coffee]

    @proxy[:coffee] = "white"
    assert_equal "_white", @proxy[:coffee]
    assert_equal "_white", @cookies[:coffee]
  end

  test "reading and writing encrypted values" do
    @proxy.encrypted[:coffee] = "black"
    assert_equal "_encrypted_black", @proxy.encrypted[:coffee]
    assert_equal "_encrypted_black", @cookies[:coffee]

    @proxy.encrypted[:coffee] = "white"
    assert_equal "_encrypted_white", @proxy.encrypted[:coffee]
    assert_equal "_encrypted_white", @cookies[:coffee]
  end

  test "reading and writing permanent values" do
    @proxy.permanent[:coffee] = "black"
    assert_equal "_permanent_black", @proxy.permanent[:coffee]
    assert_equal "_permanent_black", @cookies[:coffee]

    @proxy.permanent[:coffee] = "white"
    assert_equal "_permanent_white", @proxy.permanent[:coffee]
    assert_equal "_permanent_white", @cookies[:coffee]
  end

  test "reading and writing signed values" do
    @proxy.signed[:coffee] = "black"
    assert_equal "_signed_black", @proxy.signed[:coffee]
    assert_equal "_signed_black", @cookies[:coffee]

    @proxy.signed[:coffee] = "white"
    assert_equal "_signed_white", @proxy.signed[:coffee]
    assert_equal "_signed_white", @cookies[:coffee]
  end

  test "reading and writing combined values" do
    @proxy.encrypted.permanent.signed[:coffee] = "black"
    assert_equal "_encrypted_permanent_signed_black", @proxy.encrypted.permanent.signed[:coffee]
    assert_equal "_encrypted_permanent_signed_black", @cookies[:coffee]
  end
end
