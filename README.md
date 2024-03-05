# TestyCookie

`TestyCookie` gem provides a helper for accessing plain, permanent, signed, and encrypted cookies in Rails controller, integration, and request tests.

## Why do I need a custom helper?

In Rails, `ActionDispatch::IntegrationTest` based tests and RSpec request specs do not provide `encrypted`, `permanent` and `signed` stores when the default `cookies` helper is used (it returns `Rack::Test::CookieJar` instance). `TestyCookie` resolves this limitation by initializing a proper `ActionDispatch::Cookies::CookieJar` instance which support these stores. The included helper also propagates any changes back to the original `Rack::Test::CookieJar` instance making them correctly read in application controllers.

In `ActionController::TestCase` tests and RSpec controller specs, `cookie_jar` serves as an alias for the default `cookies` method which returns `ActionDispatch::Cookies::CookieJar` instance correctly.

## Usage

Inside your controller / integration / request test, call `cookie_jar` helper to access cookies:

```ruby
cookie_jar.encrypted[:key]
cookie_jar.signed[:key] = value
cookie_jar.signed.encrypted.permanent[:key] = value
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "testy_cookie"
```

And then execute:

```bash
$ bundle
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
