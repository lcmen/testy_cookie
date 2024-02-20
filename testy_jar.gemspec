require_relative "lib/testy_jar/version"

Gem::Specification.new do |spec|
  spec.name        = "testy_jar"
  spec.version     = TestyJar::VERSION
  spec.authors     = ["Lucas Mendelowski"]
  spec.email       = ["lucas@mendelowski.com"]
  spec.homepage    = "https://github.com/lcmen/testy_jar"
  spec.summary     = "Helpers for accessing cookies in Rails tests."
  spec.description = <<~DESCRIPTION.strip
    TestyJar provides a simple way to access plain, signed and encrypted cookies in Rails controller / request / integration tests.
  DESCRIPTION
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3"
end
