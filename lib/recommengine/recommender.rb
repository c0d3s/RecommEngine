module RecommEngine
  class Recommender
    attr_reader :data, :subject, :similarity_algorithm, :user_similarity_scores, :sum_of_weighted_ratings_by_product, :sum_of_user_similarity_scores_by_product, :rankings

    def initialize(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
      @data = data
      @subject = subject
      @similarity_algorithm = similarity
      @ratings = {}
      @user_similarity_scores = {}
      @sum_of_weighted_ratings_by_product = {}
      @sum_of_user_similarity_scores_by_product = {}
      @sum_of_weighted_ratings_by_product.default = 0
      @sum_of_user_similarity_scores_by_product.default = 0
    end

    def recs
      calculate_weighted_totals
      predicted_ratings.sort_by{ |k, v| v }.reverse
    end

    def top_match
      calculate_weighted_totals
      predicted_ratings.max_by{ |k, v| v }
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

    def rated_by_subject?(subject, product)
      return unless @data[subject][product]
      !@data[subject][product].zero? || @data[subject].include?(product)
    end

    def update_cumulative_totals(comperate, product)
      @sum_of_weighted_ratings_by_product[product] += weighted_rating(comperate, product)
      @sum_of_user_similarity_scores_by_product[product] += score(comperate)
    end

    def weighted_rating(comperate, product)
      @data[comperate][product] * score(comperate)
    end

    def average_weighted_rating(product, sum_of_ratings)
      sum_of_ratings / @sum_of_user_similarity_scores_by_product[product]
    end

    def predicted_ratings
      @sum_of_weighted_ratings_by_product.each { |product, sum_of_ratings| @ratings[product] = average_weighted_rating(product, sum_of_ratings) }
      @ratings
    end
  end
end
