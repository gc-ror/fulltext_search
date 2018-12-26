# frozen_string_literal: true

require 'arel'
require_relative './fulltext_search/version'
require_relative './fulltext_search/sql_visitor_methods'
require_relative './fulltext_search/match_against'
require_relative './fulltext_search/match_against_expressions'

module Gcl
  #
  # Fulltext search is fulltext matching feature.
  # This is now only for MySQL
  #
  module FulltextSearch
  end
end
