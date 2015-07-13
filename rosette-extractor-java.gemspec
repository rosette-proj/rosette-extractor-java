$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/extractors/java-extractor/version'

Gem::Specification.new do |s|
  s.name     = 'rosette-extractor-java'
  s.version  = ::Rosette::Extractors::JAVA_EXTRACTOR_VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron'

  s.description = s.summary = 'Extracts translatable strings from Java source code for the Rosette internationalization platform.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.requirements << "jar 'org.antlr:antlr4-runtime', '4.2'"

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", 'Gemfile', 'History.txt', 'README.md', 'Rakefile', 'rosette-extractor-java.gemspec']
end
