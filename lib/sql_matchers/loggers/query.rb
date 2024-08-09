# frozen_string_literal: true

module SqlMatchers
  module Loggers
    class Query
      IGNORED_STATEMENTS   = %w[CACHE SCHEMA]
      IGNORED_STATEMENT_RE = %r{^(?:ROLLBACK|BEGIN|COMMIT|SAVEPOINT|RELEASE)}
      IGNORED_COMMENT_RE   = %r{
        /\*(\w+='\w+',?)+\*/ # query log tags
      }x

      def initialize
        @queries = []
      end

      def self.subscribe(&) = new.subscribe(&)
      def subscribe(&block)
        ActiveSupport::Notifications.subscribed(
          logger_proc,
          'sql.active_record',
          &proc {
            result = block.call
            result.load if result in ActiveRecord::Relation # autoload relations
          }
        )

        @queries
      end

      private

      def logger_proc = proc(&method(:logger))
      def logger(event)
        unless IGNORED_STATEMENTS.include?(event.payload[:name]) || IGNORED_STATEMENT_RE.match(event.payload[:sql])
          query = event.payload[:sql].gsub(IGNORED_COMMENT_RE, '')
                                    .squish

          @queries << query
        end
      end
    end
  end
end
