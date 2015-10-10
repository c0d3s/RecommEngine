files = %w[calculator euclidean_calculator flipper matcher pearson_calculator recommender test_data]
files.each { |f| require "./lib/recommengine/#{f}" }

module RecommEngine

  DEFAULT_ALGORITHM = 'Pearson'
  DEFAULT_MATCHES_NUMBER = 3

  module_function

  def recs(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
    RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity).recs
  end

  def top_rec(data:, subject:, similarity: RecommEngine::DEFAULT_ALGORITHM)
    RecommEngine::Recommender.new(data: data, subject: subject, similarity: similarity).top_rec
  end

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