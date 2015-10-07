module RecommEngine
  class Matcher
    attr_reader :data, :subject, :similarity, :num

    def initialize(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
      @data = data
      @subject = subject
      @similarity = similarity
      @num = num
    end

    def top_matches
      all_matches.reverse[0..upper_limit]
    end

    def bottom_matches
      all_matches[0..upper_limit]
    end

    private

    def all_matches
      scores.sort_by{|k, v| v}
    end

    def scores
      scores = {}
      data.each_key do |k|
        next if subject == k
        scores[k] = similarity_calculator.new(data: data, subject: subject, comparate: k).calc
      end
      scores
    end

    def similarity_calculator
      Module.const_get("RecommEngine::#{similarity}Calculator")
    end

    def upper_limit
      num - 1
    end
  end
end
