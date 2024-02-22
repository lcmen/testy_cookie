require_relative "lib/testy_cookie/version"

Gem::Specification.new do |spec|
  spec.name = "testy_cookie"
  spec.version = TestyCookie::VERSION
  spec.authors = ["Lucas Mendelowski"]
  spec.email = ["lucas@mendelowski.com"]
  spec.homepage = "https://github.com/lcmen/testy_cookie"
  spec.summary = "Helpers for accessing cookies in Rails tests."
  spec.description = <<~DESCRIPTION.strip
    TestyCookie provides a helper to access plain, permanent, signed and encrypted cookies
    in Rails controller / integration / request tests.
  DESCRIPTION
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3"
end
