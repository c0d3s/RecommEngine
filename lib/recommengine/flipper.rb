module RecommEngine
  class Flipper
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def flip
      result = {}
      result.default = {}
      data.each_key do |user|
        data[user].each_key do |item|
          result[item] = {} if result[item].empty?
          result[item][user] = data[user][item]
        end
      end
      result
    end
  end
end