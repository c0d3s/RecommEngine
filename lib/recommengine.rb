Dir['./*.rb'].each { |f| require f }

module RecommEngine
  DEFAULT_ALGORITHM = 'Pearson'
  DEFAULT_MATCHES_NUMBER = 3
end