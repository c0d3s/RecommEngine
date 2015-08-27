describe '.EuclideanCalculator' do
  include_context "test data"
  let(:euclidean_calc) { Suadeo::EuclideanCalculator.new(data: data, subject: 'ODB', comparate: 'Raekwon') }

  describe '#calc' do
    it 'calculates euclidean similarity' do
      expect(euclidean_calc.calc).to eq(0.42640143271122083)
    end
  end
end