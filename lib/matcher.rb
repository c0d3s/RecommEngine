module Suadeo
  class Matcher
    attr_reader :data, :subject, :similarity, :num

    DEFUALT_ALGORITHM = 'Pearson'
    DEFUALT_NUMBER = 3

    def initialize(data:, subject:, similarity: DEFUALT_ALGORITHM, num: DEFUALT_NUMBER)
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
        scores[k] = similarity_calculator.new(data: @data, p1: @subject, p2: k).calc
      end
      scores
    end

    def similarity_calculator
      Module.const_get("Suadeo::#{@similarity}Calculator")
    end

    def upper_limit
      num - 1
    end
  end
end
