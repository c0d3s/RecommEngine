module RecommEngine
  class Recommender
    attr_reader :data, :subject, :similarity_algorithm, :user_similarity_scores, :sum_of_weighted_scores_by_item, :sum_of_user_similarity_scores_by_item, :rankings

    def initialize(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
      @data = data
      @subject = subject
      @similarity_algorithm = similarity
      @scores = {}
      @user_similarity_scores = {}
      @sum_of_weighted_scores_by_item = {}
      @sum_of_user_similarity_scores_by_item = {}
      @sum_of_weighted_scores_by_item.default = 0
      @sum_of_user_similarity_scores_by_item.default = 0
    end

    def recs
      calculate_weighted_totals
      predicted_scores.sort_by{ |k, v| v }.reverse
    end

    def top_rec
      calculate_weighted_totals
      predicted_scores.max_by{ |k, v| v }
    end

    private

    def calculate_weighted_totals
      @data.each_key do |comperate|
        next if is_subject?(comperate) || non_positive_similarity?(comperate)
        @data[comperate].each_key do |product|
          update_cumulative_totals(comperate, product) unless rated_by_subject?(@subject, product)
        end
      end
    end

    def is_subject?(comperate)
      comperate == @subject
    end

    def score(comperate)
      return @user_similarity_scores[comperate] if @user_similarity_scores[comperate]
      @user_similarity_scores[comperate] = similarity_calculator.new(data: @data, subject: @subject, comparate: comperate).calc
    end

    def similarity_calculator
      Module.const_get("RecommEngine::#{@similarity_algorithm}Calculator")
    end

    def non_positive_similarity?(comperate)
      score(comperate) <= 0
    end

    def scored_by_subject?(item)
      return unless @data[@subject][item]
      !@data[@subject][item].zero? || @data[@subject].include?(item)
    end

    def update_cumulative_totals(comperate, item)
      @sum_of_weighted_scores_by_item[item] += weighted_score(comperate, item)
      @sum_of_user_similarity_scores_by_item[item] += score(comperate)
    end

    def weighted_score(comperate, item)
      @data[comperate][item] * score(comperate)
    end

    def average_weighted_score(item, sum_of_scores)
      sum_of_scores / @sum_of_user_similarity_scores_by_item[item]
    end

    def predicted_scores
      @sum_of_weighted_scores_by_item.each { |item, sum_of_scores| @scores[item] = average_weighted_score(item, sum_of_scores) }
      @scores
    end
  end
end
