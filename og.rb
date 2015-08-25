require 'pry'
require 'ap'

critics = {'Ghostface Killah'=> {'The Sixth Sense'=> 2.5, 'Snakes on a Plane'=> 3.5,
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

users = {"alia"=>
  {"AMC"=>3,
   "Restaurant.com"=>2,
   "Starbucks Coffee"=>9,
   "American Eagle Outfitters"=>9,
   "JCPenney"=>4,
   "Fandango"=>2,
   "Macy's"=>273,
   "Buy Buy Baby (In Store Only)"=>1,
   "AMC Theatres"=>4,
   "Dunkin Donuts"=>2,
   "Michaels (Online Only)"=>1,
   "Home Depot"=>1,
   "Cheesecake Factory"=>1},
 "Patrick"=>
  {"Home Depot"=>40,
   "Five Guys"=>3,
   "Starbucks Coffee"=>14,
   "Dick's Sporting Goods (In Store Only)"=>3,
   "Noodles & Company"=>1,
   "Marshalls"=>9,
   "Famous Dave's BBQ"=>1,
   "T.J. Maxx"=>9,
   "Old Navy"=>4,
   "Pottery Barn"=>1,
   "Chipotle"=>1,
   "Panera Bread"=>8,
   "Bar Louie"=>3,
   "Dunkin Donuts"=>3,
   "Regal Cinemas"=>1,
   "Sears"=>2,
   "HomeGoods"=>1,
   "Shake Shack"=>1,
   "Chick-fil-A"=>2},
 "Christina"=>
  {"Sears"=>35,
   "Kmart"=>31,
   "CVS Pharmacy"=>2,
   "Michaels (Online Only)"=>8,
   "Walmart"=>25,
   "Bath & Body Works"=>6,
   "Jo Ann Fabrics"=>2,
   "Olive Garden"=>2,
   "Target"=>4,
   "IHOP"=>3,
   "GameStop"=>1,
   "Claire's"=>7,
   "Justice"=>1,
   "Bealls Outlet"=>9,
   "Denny's"=>1,
   "Burger King"=>1,
   "Old Navy"=>1,
   "Burlington Coat Factory"=>2,
   "Big Lots"=>1,
   "Michaels"=>4,
   "Home Depot"=>4,
   "Walgreens (In Store Only)"=>1,
   "Shell Gasoline"=>1,
   "Cracker Barrel"=>2,
   "AutoZone"=>1,
   "Rite Aid"=>1,
   "T.J. Maxx"=>1},
 "Robert"=>
  {"Sheetz Gasoline"=>2,
   "Five Guys"=>5,
   "Walmart"=>1,
   "Burger King"=>5,
   "Logan's Roadhouse"=>1,
   "Walgreens (In Store Only)"=>14,
   "McDonald's"=>7,
   "Subway"=>3,
   "Outback Steakhouse"=>10,
   "Potbelly"=>9,
   "Wendy's"=>3,
   "Bob Evans"=>1,
   "Dunkin Donuts"=>7,
   "Tractor Supply Company"=>1,
   "Moe's Southwest Grill"=>1,
   "Steak 'n Shake"=>1,
   "Chick-fil-A"=>3,
   "KFC"=>2,
   "Taco Bell (App Only)"=>2,
   "Boston Market"=>12,
   "Cracker Barrel"=>3,
   "Dairy Queen"=>1,
   "P. F. Changs"=>1,
   "AutoZone"=>1,
   "Roy Rogers"=>7,
   "IHOP"=>1},
 "wei"=>{"Macy's"=>162, "iTunes"=>6, "Sephora (In Store Only)"=>4},
 "sophie"=>
  {"Macy's"=>393,
   "T.J. Maxx"=>7,
   "Target"=>1,
   "Bloomingdale's"=>279,
   "Lowe's (In Store Only)"=>5,
   "Pier 1 Imports"=>8,
   "Michaels"=>6,
   "Starbucks Coffee"=>9,
   "Walmart"=>2,
   "HomeGoods"=>2,
   "Marshalls"=>1,
   "Carter's"=>2,
   "Guess"=>1,
   "Sephora"=>9,
   "GNC"=>1,
   "Bed Bath & Beyond"=>2,
   "Babies\"R\"Us"=>2},
 "Michael "=>
  {"Lowe's"=>1,
   "Lowe's (In Store Only)"=>109,
   "Home Depot"=>98,
   "Home Depot (In Store Only)"=>1,
   "Boston Market"=>1},
 "Noel"=>
   {"Lowe's"=>1,
    "Lowe's (In Store Only)"=>35,
    "Starbucks Coffee"=>2,
    "Home Depot"=>14,
    "Macy's"=>1,
    "Pier 1 Imports"=>1,
    "AMC Theatres"=>9,
    "Lands' End"=>4},
  "Daniel"=>
   {"Home Depot"=>7,
    "Lowe's (In Store Only)"=>8,
    "Starbucks Coffee"=>3,
    "Kmart"=>34,
    "Barnes & Noble"=>4,
    "Sears (In-Store Only)®"=>1,
    "Sears"=>42},
  "Melvin"=>
   {"Home Depot"=>75,
    "Starbucks Coffee"=>4,
    "Carter's"=>7,
    "Macy's"=>43,
    "Sephora"=>5,
    "Bath & Body Works"=>6,
    "Bed Bath & Beyond (In Store Only)"=>1,
    "Crate & Barrel"=>1,
    "Babies\"R\"Us"=>4,
    "iTunes"=>16,
    "IHOP"=>1,
    "Pier 1 Imports"=>3,
    "Kohl's"=>1,
    "Toys\"R\"Us"=>1},
  "Katelyn"=>
   {"Target"=>15,
    "Starbucks Coffee"=>12,
    "Michaels"=>4,
    "Ulta (In Store Only)"=>1,
    "Regal Cinemas"=>9,
    "Jamba Juice"=>3,
    "Panera Bread"=>1,
    "Sephora (In Store Only)"=>2,
    "Banana Republic"=>1,
    "Olive Garden"=>4,
    "iTunes"=>5,
    "Kohl's"=>1,
    "AMC Theatres"=>2,
    "Cold Stone Creamery"=>3,
    "Cheesecake Factory"=>1,
    "Logan's Roadhouse"=>2,
    "FreshBerry"=>1,
    "Chili's"=>1,
    "Red Robin"=>1,
    "New York & Company"=>2,
    "Old Navy"=>18,
    "Stein Mart"=>1,
    "Boston Market"=>4,
    "Togo’s"=>2,
    "Hancock Fabrics"=>1,
    "Bare Minerals"=>1,
    "Black Angus Steakhouse"=>8,
    "AutoZone"=>2,
    "Gap"=>7,
    "Marshalls"=>1,
    "JCPenney"=>5,
    "Aeropostale"=>1,
    "Jo Ann Fabrics"=>3,
    "Sports Authority (In Store Only)"=>1,
    "Sunglass Hut"=>1,
    "Nike"=>4,
    "Macy's"=>42,
    "Pagoda"=>8,
    "Chipotle"=>2,
    "H&M"=>3,
    "Fandango"=>3,
    "Boot Barn"=>1,
    "PacSun"=>1,
    "American Eagle Outfitters"=>1,
    "Pier 1 Imports"=>1,
    "Sears"=>5,
    "Macaroni Grill"=>1},
  "Rick"=>
   {"T.J. Maxx"=>5,
    "Dick's Sporting Goods (In Store Only)"=>5,
    "Home Depot"=>6,
    "Under Armour"=>1,
    "Staples"=>2,
    "Red Lobster"=>1,
    "JCPenney"=>2,
    "Lowe's (In Store Only)"=>12,
    "Chipotle"=>4,
    "Applebee's®"=>1,
    "Walgreens (In Store Only)"=>5,
    "Ace Hardware"=>1,
    "CVS Pharmacy"=>2,
    "Amazon.com"=>2,
    "Wendy's"=>1,
    "Boston Market"=>3,
    "Nike"=>7,
    "Restaurant.com"=>1,
    "Cracker Barrel"=>1,
    "P. F. Changs"=>1,
    "McDonald's"=>3,
    "Applebee's"=>3,
    "Champs (In Store Only)"=>2,
    "Bob Evans"=>2,
    "Groupon "=>9,
    "Darden Restaurants"=>9,
    "Landry's Restaurants"=>4,
    "Olive Garden"=>3,
    "Costco"=>1,
    "Walmart"=>1},
  "Michelle"=>
   {"Starbucks Coffee"=>15,
    "AMC"=>4,
    "American Eagle Outfitters"=>5,
    "Fandango"=>2,
    "Home Depot"=>16,
    "iTunes"=>2,
    "Nordstrom"=>1,
    "Kmart"=>8,
    "Cheesecake Factory"=>6,
    "Macy's"=>4,
    "Target"=>8,
    "Walmart"=>4,
    "AMC Theatres"=>1,
    "Sally Beauty Supply"=>1,
    "Cold Stone Creamery"=>2,
    "Staples"=>6,
    "Sears"=>3,
    "Nutrisystem"=>3,
    "GameStop"=>2,
    "JCPenney"=>4,
    "Apple"=>1},
  "steven"=>
   {"Home Depot"=>94,
    "Home Depot (In Store Only)"=>1,
    "Lowe's (In Store Only)"=>5,
    "Dunkin Donuts"=>1},
  "kelly"=>
   {"Under Armour"=>1,
    "Restaurant.com"=>2,
    "Michaels"=>2,
    "Target"=>2,
    "Big Lots"=>6,
    "Victoria's Secret"=>4,
    "T.J. Maxx"=>2,
    "Bed Bath & Beyond (In Store Only)"=>5,
    "Whole Foods"=>9,
    "Bed Bath & Beyond"=>5,
    "T.J. Maxx (Online Only)"=>2,
    "Red Lobster"=>4,
    "H&M"=>1,
    "Payless Shoes"=>1,
    "Home Depot"=>2,
    "Olive Garden"=>2,
    "Pier 1 Imports"=>1,
    "DSW"=>2,
    "Uniqlo"=>2,
    "AMC Theatres"=>3,
    "Walmart"=>5,
    "Amazon.com"=>1,
    "Marshalls"=>2,
    "HomeGoods"=>1,
    "Boston Market"=>44,
    "Sears"=>4,
    "Chipotle"=>6},
  "Don"=>
   {"Walmart"=>7,
    "CVS Pharmacy"=>7,
    "Shoe Carnival"=>1,
    "Pepboys"=>2,
    "Home Depot (In Store Only)"=>3,
    "Olive Garden"=>4,
    "Maui Wowi"=>1,
    "Dairy Queen"=>1,
    "Home Depot"=>11,
    "PetSmart"=>2,
    "JCPenney"=>1,
    "IHOP"=>4,
    "Shell Gasoline"=>10,
    "Uno Chicago Grill"=>2,
    "Hair Cuttery"=>1,
    "McDonald's"=>3,
    "Amazon.com"=>1,
    "O'Charley's"=>3,
    "Tiffany & Co."=>1,
    "Stop&Shop"=>1,
    "Famous Dave's BBQ"=>1,
    "Applebee's"=>1,
    "Old Country Buffet"=>4,
    "Azteca"=>1,
    "Fuddruckers"=>1,
    "Advance Auto Parts"=>1,
    "KFC"=>1,
    "Harbor Freight Tools"=>1},
  "Shoba"=>
   {"Kohl's"=>5,
    "Burlington Coat Factory"=>2,
    "JCPenney"=>1,
    "T.J. Maxx"=>12,
    "Macy's"=>22,
    "Lord & Taylor"=>5,
    "Bloomingdale's"=>19,
    "Guess"=>3,
    "Wendy's"=>1,
    "New York & Company"=>2}}


# Euclidean Distance Similarity
def es(data, p1, p2)
  sum = 0
  data[p1].each do |k, v|
    sum += ((v - data[p2][k])**2) if data[p2][k]
  end
  1.0 / (Math.sqrt(1.0 + sum))
end

# Pearson Correlation Score Similarity
def ps(data, p1, p2)
  similar_items = []
  data[p1].each_key do |k|
    similar_items << k if data[p2].keys.include?(k)
  end

  len = similar_items.length
  return 0 if len == 0

  sum1 = sum2 = sq_sum1 = sq_sum2 = product_sum = 0

  similar_items.each do |item|
    p1_val = data[p1][item]
    p2_val = data[p2][item]
    sum1 += p1_val
    sum2 += p2_val
    sq_sum1 += (p1_val**2)
    sq_sum2 += (p2_val**2)
    product_sum += p1_val * p2_val
  end

  binding.pry
  num = product_sum - (sum1 * sum2/len)
  den = Math.sqrt((sq_sum1 - (sum1**2)/len)*(sq_sum2 - (sum2**2)/len))
  den == 0 ? 0 : num/den
end

def top_matches(data, item, similarity = 'ps', num = 3)
  scores = {}
  data.each_key do |k|
    next if item == k
    scores[k] = send(similarity.to_s, data, item, k)
  end
  scores.sort_by{|k, v| v}.reverse
end

def get_recs(data, item, similarity = 'ps')
  totals = {}
  totals.default = 0
  sim_sums = {}
  sim_sums.default = 0
  data.each_key do |k|
    next if k == item
    sim = send(similarity.to_s, data, item, k)
    next if sim <= 0
    data[k].each_key do |kk|
      if data[item][kk] == 0 || !data[item].include?(kk)
        totals[kk] += data[k][kk] * sim
        sim_sums[kk] += sim
      end
    end
  end
  rankings = {}
  totals.each do |item, total|
    rankings[item] = total/sim_sums[item]
  end
  rankings.sort_by{|k, v| v}.reverse
end

def flip(data)
  result = {}
  result.default = {}
  data.each_key do |k|
    data[k].each_key do |kk|
      result[kk] = {} if result[kk].empty?
      result[kk][k] = data[k][kk]
    end
  end
  result
end


movies = flip(critics)
products = flip(users)




