describe '.matcher' do
  include_context "test data"
  let(:default_matcher) { RecommEngine::Matcher.new(data: data, subject: 'ODB') }
  let(:euclidean_matcher) { RecommEngine::Matcher.new(data: data, subject: 'ODB', similarity: 'Euclidean') }
  let(:default_2_matcher) { RecommEngine::Matcher.new(data: data, subject: 'ODB', num: 2) }

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
        expect(default_matcher.send('similarity_calculator')).to eq(Module.const_get('RecommEngine::PearsonCalculator'))
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