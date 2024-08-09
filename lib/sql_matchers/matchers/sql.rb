# frozen_string_literal: true

require 'anbt-sql-formatter/formatter'

require_relative '../normalizers/sql'

module SqlMatchers
  module Matchers
    class Sql
      attr_reader :actual, :expected

      def initialize(expected)
        @expected   = expected
        @normalizer = Normalizers::Sql.new
        @formatter  = AnbtSql::Formatter.new(
          AnbtSql::Rule.new.tap do |r|
            r.keyword         = AnbtSql::Rule::KEYWORD_UPPER_CASE
            r.function_names += %w[count sum substr date]
            r.indent_string   = '  '
          end
        )
      end

      def diffable? = true
      def matches?(actual)
        @expected = formatter.format(normalizer.normalize(expected.to_s.strip))
        @actual   = formatter.format(normalizer.normalize(actual.to_s.strip))

        @actual == @expected
      end

      def failure_message
        <<~MSG
          Expected SQL to match:
            expected:
              #{@expected.squish}
            got:
              #{@actual.squish}
        MSG
      end

      private

      attr_reader :formatter, :normalizer
    end
  end
end
