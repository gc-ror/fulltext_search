# frozen_string_literal: true

module Gcl
  module FulltextSearch
    #
    # Tokenize japanese text
    #
    class JapaneseTokenizer

      attr_reader :target_word_classes, :skip_word_classes, :skip_words

      TARGET_WORD_CLASSES = %w[名詞 動詞 形容詞 形容動詞 副詞].freeze
      SKIP_WORD_CLASSES = %w[非自立 接尾 代名詞].freeze
      SKIP_WORDS = %w[* する おる なる ある より よい].freeze

      def initialize(target_word_classes: TARGET_WORD_CLASSES,
                     skip_word_classes: SKIP_WORD_CLASSES,
                     skip_words: SKIP_WORDS)

        @target_word_classes = target_word_classes
        @skip_word_classes = skip_word_classes
        @skip_words = skip_words

        @mecab = Natto::MeCab.new
      end

      def self.xml_to_text(xml)
        Nokogiri.parse(xml).text
      end

      #
      # tokenize texts
      #
      # @param [Array<String>] texts
      # @return [String] text separated with white space
      #
      def tokenize(*texts)
        [].tap do |results|
          texts.compact.each do |text|
            @mecab.parse(text) do |token|
              feature = token.feature.split(/,/)
              if target_word_classes.include?(feature[0]) && !skip_word_classes.include?(feature[1])
                candidate = feature[6] == '*' ? token.surface : feature[6]
                results << candidate unless skip_words.include?(candidate)
              end
            end
          end
        end.join(' ')
      end
    end
  end
end
