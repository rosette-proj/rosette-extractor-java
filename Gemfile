source "https://rubygems.org"

gemspec

ruby '2.0.0', engine: 'jruby', engine_version: '1.7.15'

gem 'rosette-core', path: '~/workspace/rosette-core'

group :development, :test do
  gem 'pry', '~> 0.9.0'
  gem 'pry-nav'
  gem 'rake'
  gem 'jbundler'
end

group :test do
  gem 'rspec'
  gem 'rr'
end
