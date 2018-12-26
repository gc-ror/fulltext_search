# frozen_string_literal: true

module Gcl
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

      attr_reader :column, :expr, :boolean

      def initialize(column, expr, boolean: false)
        @column = column
        @expr = expr
        @boolean = boolean
      end
    end
  end
end
