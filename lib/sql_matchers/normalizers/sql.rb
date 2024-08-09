# frozen_string_literal: true

require 'anbt-sql-formatter/formatter'

module SqlMatchers
  module Normalizers
    class Sql
      SELECT_STAR_RE  = /[`"]?(\w+)[`"]?\s{,1}\.\s{,1}\*/
      QUOTED_IDENT_RE = /[`"](\w+)[`"]/

      def normalize(sql) = +sql.gsub(SELECT_STAR_RE, '\1.*')
                               .gsub(QUOTED_IDENT_RE, '\1')
    end
  end
end
