describe '.PearsonCalculator' do
  include_context "test data"
  let(:pearson_calc) { RecommEngine::PearsonCalculator.new(data: data, subject: 'ODB', comparate: 'Raekwon') }

  describe '#calc' do
    it 'calculates pearson similarity' do
      expect(pearson_calc.calc).to eq(0.13483997249264842)
    end
  end
end