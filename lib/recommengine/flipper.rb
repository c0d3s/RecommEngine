module RecommEngine
  class Flipper
    def initialize(data)
      @data = data
    end

    def flip
      result = {}
      result.default = {}
      @data.each_key do |k|
        @data[k].each_key do |kk|
          result[kk] = {} if result[kk].empty?
          result[kk][k] = @data[k][kk]
        end
      end
      result
    end
  end
end