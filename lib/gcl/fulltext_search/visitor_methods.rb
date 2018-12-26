module FulltextSearch
  module VisitorMethods
    #
    # @param [MatchAgainst]
    #
    def visit_FulltextSearch_MatchAgainst(o, collector)
      collector << 'MATCH ('
      visit o.column, collector
      collector << ') AGAINST ('
      visit o.expr, collector
      collector << ')'
    end
  end

  Arel::Visitors::ToSql.include VisitorMethods
end
