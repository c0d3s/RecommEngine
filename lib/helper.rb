module RecommEngine
  module Helper
    module RecEngine
      module_function

      def recommendations(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
        RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity)
      end

      def top_matches(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
        RecommEngine::Matcher.new(data: data, subject: subject, similarity: similarity, num: num)
      end

      def flip(data)
        RecommEngine::Flipper.new(data).flip
      end
    end
  end
end