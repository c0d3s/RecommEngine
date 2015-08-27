require 'flipper'
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
