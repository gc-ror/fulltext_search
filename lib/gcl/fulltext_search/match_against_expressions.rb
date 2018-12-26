# frozen_string_literal: true

module Gcl
  module FulltextSearch
    #
    # Add match_against expression feature to attribute
    #
    module MatchAgainstExpressions
      def match_against(expr, boolean: false)
        MatchAgainst.new self, expr, boolean: boolean
      end
    end

    Arel::Attributes::Attribute.include MatchAgainstExpressions
  end
end
