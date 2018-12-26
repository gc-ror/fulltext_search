module Gcl
  module FulltextSearch
    #
    # MatchAgainst visitor methods for MySQL
    #
    module MysqlVisitorMethods
      #
      # @param [MatchAgainst]
      #
      def visit_Gcl_FulltextSearch_MatchAgainst(o, collector)
        collector << 'MATCH ('
        visit o.column, collector
        collector << ') AGAINST ('

        quoted = case o.expr
                 when String
                   Arel::Nodes.build_quoted o.expr
                 when Array
                   Arel::Nodes.build_quoted o.expr.map(&:to_s).compact.join(' ')
                 else
                   o.expr
                 end

        visit quoted, collector

        collector << (o.boolean ? ' IN BOOLEAN MODE)' : ')')
      end
    end

    Arel::Visitors::MySQL.include MysqlVisitorMethods
  end
end
