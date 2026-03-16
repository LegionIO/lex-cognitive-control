# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_control/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-control'
  spec.version       = Legion::Extensions::CognitiveControl::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'Cognitive control meta-controller for LegionIO'
  spec.description   = 'Cognitive control for LegionIO — ' \
                       'automatic vs. controlled processing, goal management, and effort allocation'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-control'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = spec.homepage
  spec.metadata['documentation_uri'] = "#{spec.homepage}/blob/master/README.md"
  spec.metadata['changelog_uri']     = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['bug_tracker_uri']   = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files         = Dir['lib/**/*']
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
