# TestyCookie

`TestyCookie` provides a helper to access plain, permanent, signed and encrypted cookies in Rails controller / integration / request tests.

## Usage

Inside your controller / integration / request test, call `cookies_jar` helper to access cookies jar:

```ruby
cookies_jar.encrypted[:key]
cookies_jar.signed[:key] = value
cookies_jar.signed.encrypted.permanent[:key] = value
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
