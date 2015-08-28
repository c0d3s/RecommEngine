module RecommEngine
  class EuclideanCalculator < Calculator
    attr_reader :data, :subject, :comparate

    def initialize(data:, subject:, comparate:)
      super
    end

    def calc
      1.0 / (Math.sqrt(1.0 + sum_simalarities))
    end

    private

    def sum_simalarities
      @data[@subject].map{ |product, score| ((score - data[comparate][product])**2) if data[comparate][product] }.compact.inject(:+)
    end
  end
end
