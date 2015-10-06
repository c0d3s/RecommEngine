module RecommEngine
  class Recommender
    attr_reader :data, :subject, :similarity, :similarity_scores, :totals, :similarity_sums

    def initialize(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
      @data = data
      @subject = subject
      @similarity = similarity
      @similarity_scores = {}
      @totals = {}
      @similarity_sums = {}
      @totals.default = 0
      @similarity_sums.default = 0
    end

    def recs
      @data.each_key do |comperate|
        next if is_subject?(comperate) || non_positive_similarity?(comperate)
        @data[comperate].each_key do |product|
          update_sums(comperate, product) unless scored_by_subject?(@subject, product)
        end
      end
      rankings
    end

    private

    def is_subject?(comperate)
      comperate == @subject
    end

    def score(comperate)
      return @similarity_scores[comperate] if @similarity_scores[comperate]
      @similarity_scores[comperate] = similarity_calculator.new(data: @data, subject: @subject, comparate: comperate).calc
    end

    def similarity_calculator
      Module.const_get("RecommEngine::#{@similarity}Calculator")
    end

    def non_positive_similarity?(comperate)
      score(comperate) <= 0
    end

    def scored_by_subject?(subject, product)
      if @data[subject][product]
        !@data[subject][product].zero?  || @data[subject].include?(product)
      end
    end

    def update_sums(comperate, product)
      @totals[product] += @data[comperate][product] * score(comperate)
      @similarity_sums[product] += score(comperate)
    end

    def rankings
      rankings = {}
      @totals.each { |subject, total| rankings[subject] = total / @similarity_sums[subject] }
      rankings.sort_by{|k, v| v}.reverse
    end
  end
end
