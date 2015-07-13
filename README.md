rosette-extractor-java
====================

Extracts translatable strings from Java source files for the Rosette internationalization platform.

## Installation

`gem install rosette-extractor-java`

Then, somewhere in your project:

```ruby
require 'rosette/extractors/java-extractor'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform that extracts translatable phrases from git repositories. rosette-extractor-java is capable of identifying translatable phrases in Java source files, specifically those that use one of the following translation strategies:

1. `I18n.t()` function calls, in the style of the i18n gem for Ruby on Rails.

Additional types of function call are straightforward to support. Open an issue or pull request if you'd like to see support for another strategy.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding `I18n.t()` support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/extractors/java-extractor'

rosette_config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo_config.add_extractor('java/i18n') do |extractor_config|
      extractor_config.match_file_extension('.java')
    end
  end
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

See the documentation contained in [rosette-core](https://github.com/rosette-proj/rosette-core) for a complete list of extractor configuration options in addition to `match_file_extensions`.

### Standalone Usage

While most of the time rosette-extractor-java will probably be used alongside rosette-server (or similar), there may arise use cases where someone might want to use it on its own. The `extract_each_from` method on `I18nExtractor` yields `Rosette::Core::Phrase` objects (or returns an enumerator):

```ruby
java_source_code = "public class Foo { public void method() { I18n.t('foo.bar'); } }"
extractor = Rosette::Extractors::JavaExtractor::I18nExtractor.new
extractor.extract_each_from(java_source_code) do |phrase|
  phrase.meta_key # => "foo.bar"
end
```

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
