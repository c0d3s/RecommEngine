module RecommEngine
  class PearsonCalculator < Calculator
    attr_accessor :sum_of_subject_ratings, :sum_of_comparate_ratings, :sum_of_sq_subject_ratings, :sum_of_sq_comparate_ratings, :sum_of_ratings_product

    def initialize(*args)
      super
      @sum_of_subject_ratings = @sum_of_comparate_ratings = @sum_of_sq_subject_ratings = @sum_of_sq_comparate_ratings = @sum_of_ratings_product = 0
    end

    def calc
      return 0 if number_of_hits < 2
      sum_all_similarities
      perform_equation
    end

    private

    def similar_items
      @similar_items ||= @data[@subject].map{ |k, v| k if @data[@comparate].keys.include?(k) }.compact
    end

    def number_of_hits
      @number_of_hits ||= similar_items.length
    end

    def sum_all_similarities
      similar_items.each{ |item| sum_simalarities(item) }
    end

    def sum_simalarities(item)
      subject_val = @data[@subject][item]
      comparate_val = @data[@comparate][item]
      @sum_of_subject_ratings += subject_val
      @sum_of_comparate_ratings += comparate_val
      @sum_of_sq_subject_ratings += subject_val**2.0
      @sum_of_sq_comparate_ratings += comparate_val**2.0
      @sum_of_ratings_product += subject_val * comparate_val
    end

    def perform_equation
      denominator.zero? ? 0 : numerator/denominator
    end

    def numerator
      @sum_of_ratings_product - (@sum_of_subject_ratings * @sum_of_comparate_ratings/number_of_hits)
    end

    def denominator
      @denominator ||= Math.sqrt((@sum_of_sq_subject_ratings - (@sum_of_subject_ratings**2.0)/number_of_hits)*(@sum_of_sq_comparate_ratings - (@sum_of_comparate_ratings**2.0)/number_of_hits))
    end
  end
end
