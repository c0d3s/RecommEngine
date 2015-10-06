describe '.recommender' do
  include_context "test data"
  let(:default_recommender) { RecommEngine::Recommender.new(data: data, subject: 'Raekwon') }
  let(:euclidean_recommender) { RecommEngine::Recommender.new(data: data, subject: 'Raekwon', similarity: 'Euclidean') }

  describe '#initialize' do
    it 'defaults to Pearson similarity algorithm if none is specified' do
      expect(default_recommender.similarity_algorithm).to eq('Pearson')
    end
  end

  context 'when default calculator' do
    describe '#recs' do
      it 'utilizes Pearson algorithm' do
        expect(default_recommender.send('similarity_calculator')).to eq(Module.const_get('RecommEngine::PearsonCalculator'))
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
