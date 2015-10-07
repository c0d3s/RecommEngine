module RecommEngine
  class EuclideanCalculator < Calculator
    def calc
      1.0 / (Math.sqrt(1.0 + sum_of_squared_distances))
    end

    private

    def squared_distances
      data[subject].map{ |item, subject_score| square_of_distance(item, subject_score) if comparate_score(item) }.compact
    end

    def sum_of_squared_distances
      squared_distances.inject(:+)
    end

    def comparate_score(item)
      data[comparate][item]
    end

    def square_of_distance(item, subject_score)
      (subject_score - comparate_score(item))**2
    end
  end
end
