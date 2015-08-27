describe '.recommender' do
  include_context "test data"
  let(:flipper) { Suadeo::Flipper.new(data) }

  describe '#flip' do
    it 'flips products and users' do
      expect(flipper.flip).to eq(
        {"The Sixth Sense"=>
          {"Ghostface Killah"=>2.5,
           "RZA"=>3.0,
           "Raekwon"=>2.5,
           "Method Man"=>3.0,
           "ODB"=>3.0},
         "Snakes on a Plane"=>
          {"Ghostface Killah"=>3.5,
           "RZA"=>3.5,
           "Raekwon"=>3.0,
           "GZA"=>3.5,
           "Method Man"=>4.0,
           "ODB"=>4.0,
           "Inspectah Deck"=>4.5},
         "27 Dresses"=>
          {"Ghostface Killah"=>3.0,
           "RZA"=>1.5,
           "GZA"=>3.0,
           "Method Man"=>2.0},
         "The Avengers"=>
          {"Ghostface Killah"=>3.5,
           "RZA"=>5.0,
           "Raekwon"=>3.5,
           "GZA"=>4.0,
           "Method Man"=>3.0,
           "ODB"=>5.0,
           "Inspectah Deck"=>4.0},
         "Pootie Tang"=>
          {"Ghostface Killah"=>2.5,
           "RZA"=>3.5,
           "GZA"=>2.5,
           "Method Man"=>2.0,
           "ODB"=>3.5,
           "Inspectah Deck"=>1.0},
         "Titanic"=>
          {"Ghostface Killah"=>3.0,
           "RZA"=>3.0,
           "Raekwon"=>4.0,
           "GZA"=>4.5,
           "Method Man"=>3.0,
           "ODB"=>3.0}
        }
      )
    end
  end
end
