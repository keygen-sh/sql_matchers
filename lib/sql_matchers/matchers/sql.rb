# frozen_string_literal: true

require 'anbt-sql-formatter/formatter'

module SqlMatchers
  module Matchers
    class Sql
      QUOTED_IDENT_RE = /[`"](\w+)[`"]/

      attr_reader :actual, :expected

      def initialize(expected)
        @expected  = expected
        @formatter = AnbtSql::Formatter.new(
          AnbtSql::Rule.new.tap do |r|
            r.keyword         = AnbtSql::Rule::KEYWORD_UPPER_CASE
            r.function_names += %w[count sum substr date]
            r.indent_string   = '  '
          end
        )
      end

      def diffable? = true
      def matches?(actual)
        @expected = formatter.format(+expected.to_s.strip)
                             .gsub(QUOTED_IDENT_RE, '\1')

        @actual = formatter.format(+actual.to_s.strip)
                           .gsub(QUOTED_IDENT_RE, '\1')

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

      attr_reader :formatter
    end
  end
end
