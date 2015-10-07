module RecommEngine
  class PearsonCalculator < Calculator
    attr_reader :sum_of_subject_scores, :sum_of_comparate_scores, :sum_of_sq_subject_scores, :sum_of_sq_comparate_scores, :sum_of_scores_product, :_number_of_hits, :_similar_items

    def initialize(*args)
      super
      @sum_of_subject_scores = @sum_of_comparate_scores = @sum_of_sq_subject_scores = @sum_of_sq_comparate_scores = @sum_of_scores_product = 0
    end

    def calc
      return 0 if number_of_hits < 2
      sum_all_scores
      perform_equation
    end

    private

    def similar_items
      @_similar_items ||= data[subject].map{ |k, v| k if data[comparate].keys.include?(k) }.compact
    end

    def number_of_hits
      @_number_of_hits ||= similar_items.length
    end

    def sum_all_scores
      similar_items.each{ |item| sum_scores_for(item) }
    end

    def sum_scores_for(item)
      subject_val = data[subject][item]
      comparate_val = data[comparate][item]
      @sum_of_subject_scores += subject_val
      @sum_of_comparate_scores += comparate_val
      @sum_of_sq_subject_scores += subject_val**2.0
      @sum_of_sq_comparate_scores += comparate_val**2.0
      @sum_of_scores_product += subject_val * comparate_val
    end

    def perform_equation
      denominator.zero? ? 0 : numerator/denominator
    end

    def numerator
      sum_of_scores_product - (sum_of_subject_scores * sum_of_comparate_scores/number_of_hits)
    end

    def denominator
      @_denominator ||= Math.sqrt((sum_of_sq_subject_scores - (sum_of_subject_scores**2.0)/number_of_hits)*(sum_of_sq_comparate_scores - (sum_of_comparate_scores**2.0)/number_of_hits))
    end
  end
end
