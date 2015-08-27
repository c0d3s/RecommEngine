module Suadeo
  class Calc
    def self.euclidean(data:, subject:, comparate:)
      EuclideanCalculator.new(data: data, subject: subject, comparate: comparate).calc
    end

    def self.pearson(data:, subject:, comparate:)
      PearsonCalculator.new(data: data, subject: subject, comparate: comparate).calc
    end
  end
end
