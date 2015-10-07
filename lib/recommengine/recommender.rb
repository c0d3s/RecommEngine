module RecommEngine
  class Recommender
    attr_reader :data, :subject, :similarity_algorithm, :user_similarity_scores, :sum_of_weighted_scores_by_item, :sum_of_user_similarity_scores_by_item, :predicted_scores

    def initialize(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
      @data = data
      @subject = subject
      @similarity_algorithm = similarity
      @predicted_scores = {}
      @user_similarity_scores = {}
      @sum_of_weighted_scores_by_item = {}
      @sum_of_user_similarity_scores_by_item = {}
      @sum_of_weighted_scores_by_item.default = 0
      @sum_of_user_similarity_scores_by_item.default = 0
    end

    def recs
      calculate_weighted_totals
      calculate_predicted_scores
      predicted_scores.sort_by{ |item, score| score }.reverse
    end

    def top_rec
      calculate_weighted_totals
      calculate_predicted_scores
      predicted_scores.max_by{ |item, score| score }
    end

    private

    def calculate_weighted_totals
      comparates.each do |comparate|
        data[comparate].each_key{ |item| update_cumulative_totals(comparate, item) unless scored_by_subject?(item) }
      end
    end

    def comparates
      data.dup.delete_if{ |user, item| user == subject || non_positive_similarity?(user) }.keys
    end

    def non_positive_similarity?(comparate)
      similarity_score(comparate) <= 0
    end

    def similarity_score(comparate)
      user_similarity_scores[comparate] ||= similarity_calculator.new(data: calculator_data(comparate), subject: subject, comparate: comparate).calc
    end

    def similarity_calculator
      Module.const_get("RecommEngine::#{similarity_algorithm}Calculator")
    end

    def calculator_data(comparate)
      data.select{ |user, item| user == subject || user == comparate }
    end

    def calculate_predicted_scores
      sum_of_weighted_scores_by_item.each { |item, sum_of_scores| predicted_scores[item] = average_weighted_similarity_score(item, sum_of_scores) }
    end

    def scored_by_subject?(item)
      data[subject][item] && !data[subject][item].zero?
    end

    def update_cumulative_totals(comparate, item)
      sum_of_weighted_scores_by_item[item] += weighted_similarity_score(comparate, item)
      sum_of_user_similarity_scores_by_item[item] += similarity_score(comparate)
    end

    def weighted_similarity_score(comparate, item)
      data[comparate][item] * similarity_score(comparate)
    end

    def average_weighted_similarity_score(item, sum_of_scores)
      sum_of_scores / sum_of_user_similarity_scores_by_item[item]
    end
  end
end
