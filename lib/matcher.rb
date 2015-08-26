module Suadeo
  class Matcher
    def initialize(data:, subject:, similarity:, num:)
      @data = :data
      @subject = :subject
      @similarity = :similarity
      @num = :num
    end

    def top_matches
      bottom_matches.reverse
    end

    def bottom_matches
      scores.sort_by{|k, v| v}.reverse
    end

    private

    def scores
      scores = {}
      data.each_key do |k|
        next if subject == k
        scores[k] = Module.const_get("Suadeo::Calc").send("#{@similarity}").send('new', data: @data, p1: @subject, p2: @k).send('calc')
      end
    end
  end
end
