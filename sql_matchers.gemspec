# frozen_string_literal: true

require_relative 'lib/sql_matchers/version'

Gem::Specification.new do |spec|
  spec.name        = 'sql_matchers'
  spec.version     = SqlMatchers::VERSION
  spec.authors     = ['Zeke Gabrielse']
  spec.email       = ['oss@keygen.sh']
  spec.summary     = 'Query assertions and SQL matchers for RSpec.'
  spec.description = 'Query assertions and SQL matchers for RSpec.'
  spec.homepage    = 'https://github.com/keygen-sh/sql_matchers'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.1'
  spec.files                 = %w[LICENSE CHANGELOG.md CONTRIBUTING.md SECURITY.md README.md] + Dir.glob('lib/**/*')
  spec.require_paths         = ['lib']

  spec.add_dependency 'activerecord', '>= 6.0'
  spec.add_dependency 'anbt-sql-formatter'

  spec.add_development_dependency 'temporary_tables', '~> 1.0.0.pre.rc.1'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
end
