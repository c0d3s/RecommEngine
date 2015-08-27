require 'matcher'
require 'calculator'
require 'euclidean_calculator'
require 'pearson_calculator'
require 'pry'

describe '.matcher' do
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
  let(:default_matcher) { Suadeo::Matcher.new(data: data, subject: 'ODB') }
  let(:euclidean_matcher) { Suadeo::Matcher.new(data: data, subject: 'ODB', similarity: 'Euclidean') }
  let(:default_2_matcher) { Suadeo::Matcher.new(data: data, subject: 'ODB', num: 2) }

  describe '#initialize' do
    it 'defaults to Pearson similarity algorithm if none is specified' do
      expect(default_matcher.similarity).to eq('Pearson')
    end

    it 'defaults to top 3 matches if num is not specified' do
      expect(default_matcher.num).to eq(3)
    end
  end

  context 'when default calculator' do
    describe '#bottom_matches' do
      it 'utilizes Pearson algorithm' do
        expect(default_matcher.send('similarity_calculator')).to eq(Module.const_get('Suadeo::PearsonCalculator'))
      end

      it 'returns bottom most matches' do
        expect(default_matcher.bottom_matches).to eq([["GZA", 0.02857142857142857], ["Raekwon", 0.13483997249264842], ["Method Man", 0.21128856368212925]])
      end
    end

    describe '#top_matches' do
      it 'returns bottom most matches' do
        expect(default_matcher.top_matches).to eq([["RZA", 0.963795681875635], ["Ghostface Killah", 0.7470178808339965], ["Inspectah Deck", 0.66284898035987]])
      end
    end
  end

  context 'when euclidean calculator' do
    describe '#bottom_matches' do
      it 'returns bottom most matches' do
        expect(euclidean_matcher.bottom_matches).to eq([["Inspectah Deck", 0.34299717028501764], ["Method Man", 0.3713906763541037], ["Raekwon", 0.42640143271122083]])
      end
    end

    describe '#top_matches' do
      it 'returns bottom most matches' do
        expect(euclidean_matcher.top_matches).to eq([["RZA", 0.8944271909999159], ["Ghostface Killah", 0.4588314677411235], ["GZA", 0.42640143271122083]])
      end
    end
  end

  context 'when specified number' do
    describe '#top_matches' do
      it 'returns 2 records' do
        expect(default_2_matcher.top_matches.length).to eq(2)
      end
    end

    describe '#bottom_matches' do
      it 'returns 2 records' do
        expect(default_2_matcher.bottom_matches.length).to eq(2)
      end
    end
  end
end