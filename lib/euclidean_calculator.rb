module Suadeo
  class EuclideanCalculator < Calculator
    attr_reader :data, :p1, :p2

    def initialize(data:, p1:, p2:)
      super
    end

    def calc
      1.0 / (Math.sqrt(1.0 + sum_simalarities))
    end

    private

    def sum_simalarities
      @data[@p1].map{ |k, v| ((v - data[p2][k])**2) if data[p2][k] }.compact.inject(:+)
    end
  end
end
