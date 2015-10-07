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
      similarity_scores.sort_by{|k, v| v}
    end

    def similarity_scores
      scores = {}
      comparates.each do |comparate|
        scores[comparate] = similarity_calculator.new(data: data, subject: subject, comparate: comparate).calc
      end
      scores
    end

    def similarity_calculator
      Module.const_get("RecommEngine::#{similarity}Calculator")
    end

    def upper_limit
      num - 1
    end

    def comparates
      data.dup.delete_if{ |k,v| k == subject }.keys
    end
  end
end
