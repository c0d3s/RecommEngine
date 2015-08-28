Dir['./lib/*.rb'].each { |f| require f }

module RecommEngine
  DEFAULT_ALGORITHM = 'Pearson'
  DEFAULT_MATCHES_NUMBER = 3

  def recommendations(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
    RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity).recs
  end

  alias_method :recs, :recommendations

  def top_matches(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
    RecommEngine::Matcher.new(data: data, subject: subject, similarity: similarity, num: num).top_matches
  end

  def bottom_matches(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
    RecommEngine::Matcher.new(data: data, subject: subject, similarity: similarity, num: num).bottom_matches
  end

  def flip(data)
    RecommEngine::Flipper.new(data).flip
  end

  module_function :recommendations, :recs, :top_matches, :flip
end