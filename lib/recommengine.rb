files = %w[calculator euclidean_calculator flipper matcher pearson_calculator recommender test_data]
files.each { |f| require "./lib/recommengine/#{f}" }

module RecommEngine
  extend self

  DEFAULT_ALGORITHM = 'Pearson'
  DEFAULT_MATCHES_NUMBER = 3

  def recommendations(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
    RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity).recs
  end

  alias_method :recs, :recommendations

  def top_recommendation(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
    RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity).top_rec
  end

  alias_method :top_rec, :top_recommendation

  def similar_users(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
    RecommEngine::Matcher.new(data: data, subject: subject, similarity: similarity, num: num).top_matches
  end

  def dissimilar_users(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM, num: RecommEngine::DEFAULT_MATCHES_NUMBER)
    RecommEngine::Matcher.new(data: data, subject: subject, similarity: similarity, num: num).bottom_matches
  end

  def flip(data)
    RecommEngine::Flipper.new(data).flip
  end
end