# frozen_string_literal: true

require_relative 'matchers/query'
require_relative 'matchers/sql'

module SqlMatchers
  module Matchers
    def match_query(...)   = Query.new(...)
    def match_queries(...) = match_query(...)
    def match_sql(...)     = Sql.new(...)
  end
end
