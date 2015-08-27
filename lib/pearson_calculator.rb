module RecommEngine
  class PearsonCalculator < Calculator
    attr_accessor :sum1, :sum2, :sq_sum1, :sq_sum2, :product_sum

    def initialize(data:, subject:, comparate:)
      super
      @sum1 = @sum2 = @sq_sum1 = @sq_sum2 = @product_sum = 0
    end

    def calc
      return 0 if similar_items.empty?
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
      @sum1 += subject_val
      @sum2 += comparate_val
      @sq_sum1 += subject_val**2
      @sq_sum2 += comparate_val**2
      @product_sum += subject_val * comparate_val
    end

    def perform_equation
      denominator.zero? ? 0 : numerator/denominator
    end

    def numerator
      @product_sum - (@sum1 * @sum2/number_of_hits)
    end

    def denominator
      @denominator ||= Math.sqrt((@sq_sum1 - (@sum1**2)/number_of_hits)*(@sq_sum2 - (@sum2**2)/number_of_hits))
    end
  end
end
