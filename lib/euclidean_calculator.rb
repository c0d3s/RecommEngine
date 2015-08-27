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
      @data[@subject].map{ |k, v| ((v - data[comparate][k])**2) if data[comparate][k] }.compact.inject(:+)
    end
  end
end
