# frozen_string_literal: true

require 'arel'
require 'natto'
require_relative './fulltext_search/version'
require_relative './fulltext_search/mysql_visitor_methods'
require_relative './fulltext_search/match_against'
require_relative './fulltext_search/match_against_expressions'
require_relative './fulltext_search/japanese_tokenizer'

module Gcl
  #
  # Fulltext search is fulltext matching feature.
  # This is now only for MySQL
  #
  module FulltextSearch
  end
end
