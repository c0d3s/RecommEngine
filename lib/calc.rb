module Suadeo
  class Calc
    def self.euclidean(data:, p1:, p2:)
      EuclideanCalculator.new(data: data, p1: p1, p2: p2).calc
    end

    def self.pearson(data:, p1:, p2:)
      PearsonCalculator.new(data: data, p1: p1, p2: p2).calc
    end
  end
end
