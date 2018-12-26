# frozen_string_literal: true

module FulltextSearch

  #
  # Match against expression
  #
  class MatchAgainst < Arel::Nodes::Node
    include Arel::Expressions
    include Arel::Predications
    include Arel::OrderPredications
    include Arel::AliasPredication
    include Arel::Math

    attr_reader :column, :expr

    def initialize(column, expr)
      @column = column
      @expr = expr
    end
  end
end
