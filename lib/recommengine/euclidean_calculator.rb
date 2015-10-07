module RecommEngine
  class EuclideanCalculator < Calculator
    def calc
      1.0 / (Math.sqrt(1.0 + sum_simalarities))
    end

    private

    def sum_simalarities
      data[subject].map{ |item, subject_score| square_of_distance(item, subject_score) if comparate_score(item) }.compact.inject(:+)
    end

    def comparate_score(item)
      data[comparate][item]
    end

    def square_of_distance(item, subject_score)
      (subject_score - comparate_score(item))**2
    end
  end
end
