# encoding: UTF-8

require 'spec_helper'

include Rosette::Extractors

describe JavaExtractor::I18nExtractor do
  let(:extractor) do
    JavaExtractor::I18nExtractor.new
  end

  FIXTURE_MANIFEST[:i18n].each_pair do |expected_file, expected_phrases|
    it "extracts phrases correctly from #{expected_file}" do
      source_file = File.join(FIXTURE_DIR, expected_file)

      extractor.extract_each_from(File.read(source_file)) do |actual_phrase|
        expect(expected_phrases).to include(actual_phrase.key)
        expected_phrases.delete(actual_phrase.key)
      end

      expect(expected_phrases).to be_empty
    end
  end
end
