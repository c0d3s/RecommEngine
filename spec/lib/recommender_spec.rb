require 'recommender'
require 'calculator'
require 'euclidean_calculator'
require 'pearson_calculator'
require 'pry'

describe '.recommender' do
  let(:data) {
    {'Ghostface Killah'=> {'The Sixth Sense'=> 2.5, 'Snakes on a Plane'=> 3.5,
 '27 Dresses'=> 3.0, 'The Avengers'=> 3.5, 'Pootie Tang'=> 2.5,
 'Titanic'=> 3.0},
'RZA'=> {'The Sixth Sense'=> 3.0, 'Snakes on a Plane'=> 3.5,
 '27 Dresses'=> 1.5, 'The Avengers'=> 5.0, 'Titanic'=> 3.0,
 'Pootie Tang'=> 3.5},
'Raekwon'=> {'The Sixth Sense'=> 2.5, 'Snakes on a Plane'=> 3.0,
 'The Avengers'=> 3.5, 'Titanic'=> 4.0},
'GZA'=> {'Snakes on a Plane'=> 3.5, '27 Dresses'=> 3.0,
 'Titanic'=> 4.5, 'The Avengers'=> 4.0,
 'Pootie Tang'=> 2.5},
'Method Man'=> {'The Sixth Sense'=> 3.0, 'Snakes on a Plane'=> 4.0,
 '27 Dresses'=> 2.0, 'The Avengers'=> 3.0, 'Titanic'=> 3.0,
 'Pootie Tang'=> 2.0},
'ODB' => {'The Sixth Sense'=> 3.0, 'Snakes on a Plane'=> 4.0,
 'Titanic'=> 3.0, 'The Avengers'=> 5.0, 'Pootie Tang'=> 3.5},
'Inspectah Deck'=> {'Snakes on a Plane'=>4.5, 'Pootie Tang'=>1.0, 'The Avengers'=>4.0}}
}

  let(:default_recommender) { Suadeo::Recommender.new(data: data, subject: 'Raekwon') }
  let(:euclidean_recommender) { Suadeo::Recommender.new(data: data, subject: 'Raekwon', similarity: 'Euclidean') }

  describe '#initialize' do
    it 'defaults to Pearson similarity algorithm if none is specified' do
      expect(default_recommender.similarity).to eq('Pearson')
    end
  end

  context 'when default calculator' do
    describe '#recs' do
      it 'utilizes Pearson algorithm' do
        expect(default_recommender.send('similarity_calculator')).to eq(Module.const_get('Suadeo::PearsonCalculator'))
      end

      it 'returns ranked recommendations' do
        expect(default_recommender.recs).to eq([["27 Dresses", 2.8092760065251268], ["Pootie Tang", 2.694636703980363]])
      end
    end
  end

  context 'when euclidean calculator' do
    it 'returns ranked recommendations' do
      expect(euclidean_recommender.recs).to eq([["27 Dresses", 2.493876153902421], ["Pootie Tang", 2.445567381116539]])
    end
  end
end
