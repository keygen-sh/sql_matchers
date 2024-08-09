# frozen_string_literal: true

require_relative '../loggers/query'

module SqlMatchers
  module Matchers
    class Query
      def initialize(count: nil, &block)
        @count = count
        @block = block
      end

      def supports_block_expectations? = true
      def supports_value_expectations? = true

      def matches?(block)
        @queries = Loggers::Query.subscribe(&block)

        (@count.nil? || @queries.size == @count) && (
          @block.nil? || @block.call(@queries)
        )
      end

      def failure_message
        "expected to match #{@count} queries but got #{@queries.size}"
      end

      def failure_message_when_negated
        "expected to not match #{@count} queries"
      end
    end
  end
end
