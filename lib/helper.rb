module Suadeo
  module Helper
    module RecEngine
      module_function

      DEFAULT_ALGORITHM = 'Pearson'
      TOP_MATCHES_NUMBER = 5

      def recommendations(data:, subject:, similarity: DEFAULT_ALGORITHM)
        Suadeo::Recommender.new(data: data, subject: subject, similarity: similarity)
      end

      def top_matches(data:, subject:, similarity: DEFAULT_ALGORITHM, num: TOP_MATCHES_NUMBER)
        Suadeo::Matcher.new(data: data, subject: subject, similarity: similarity, num: num)
      end
    end
  end
end