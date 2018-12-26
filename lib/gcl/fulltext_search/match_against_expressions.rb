# frozen_string_literal: true

module FulltextSearch
  #
  # Add match_against expression feature to attribute
  #
  module MatchAgainstExpressions
    def match_against(expr)
      MatchAgainst.new self, expr
    end
  end

  Arel::Attributes::Attribute.include MatchAgainstExpressions
end
