# RecommEngine
A plug-and-play recommendation engine gem supporting multiple similarity algorithms.  Use to recommend items for people, or people for items.

## Installation
Simply `gem install recommengine` or if using bundler, add recommengine to your Gemfile thusly
```ruby
require 'recommengine'
```

## Methodology
RecommEngine uses a weighted scoring system in conjunction with a similarity algorithm (of either the Pearson or Euclidean variety) to suggest items to users based on their prior behavior in accordance with the principle of collaborative filtering.  In order to utilize this gem, you must have users, items, and some kind of numerical scoring system that describes a user's interaction with a given item.
Items need not be physical products, as recommendation engines have applications outside the ecommerce/marketplace realm. Items can be things like movies or web links as well.  Similarly, scores aren't limited to only to ratings of physical items -- they only need to be a numerical representation that describes a user's behavior.  For example:


|(Score)| Physical Goods | Movies |  Web Habits  |
--------|:--------------:|:------:|-------------:|
|   0   | No Interaction |   *    | Didn't Click |
|   1   | Browsed        |   **   | Clicked      |
|   2   | Searched For   |   ***  | Searched for |
|   3   | Bought         |   **** |     N/A      |
|   4   | Bought > 1x    |   *****|     N/A      |

### Euclidean Algorithm

The Euclidean distance algorithm is a simplistic similarity measure that determines how close two points are when plotted in [Cartesian coordinates](https://en.wikipedia.org/wiki/Cartesian_coordinate_system).  This algorithm essentially calculates average distance by means of the [Pythagorean Theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem) and inverts the result so that a score of '1.0' represents a perfect correlation (both users have identical preferences) and a score of '0.0' representents no correlation. Read more about Euclidean distance on [wikipedia](https://en.wikipedia.org/wiki/Euclidean_distance).

### Pearson Algorithm

The Pearson similarity score adds a bit more complexity.  While not as intuitive as calculating Euclidean distance, the Pearson correlation determines the ratio how much all scored items between two users vary altogether to the product of how much they vary individually, such that a score of '1.0' represents a perfect correlation, a score of '0.0' represents no correlation, and a score of '-1.0' represents an inverse (negative) correlation.  The general idea from a Cartesian standpoint (assuming we have a `subject` user on the X axis, a `comparate` user on the Y axis, scores correlating to axial position, and a scatter plot of items) is to determine the 'best-fit' line that comes as close as possible to touching all items (a score of 1.0 could be represented by a perfectly diagonal line that touches all items).  Feel free to read up on it on [wikipedia](https://en.wikipedia.org/wiki/Pearson_item-moment_correlation_coefficient).  The Pearson method is the default similarity algorithm in RecommEngine, primarily because it compensates for grade inflation and can determine negative correlations between users' preferences.

### How Recommendations Work

When passing `data:` and `subject:` arguments to the recommendations method, RecommEngine will compare the similarity between all members of the `data` hash and the `subject` using the specified `similarity` algorithm, and determine a weighted predicted score for each item based upon each user's similarity to the subject and the scores that each user gave each item.  Only items that the subject has not yet scored will be returned (no need to recommend an item to a user that he/she has already interacted with).  The items are sorted by score in descending order.

## Usage

The RecommEngine module can be safely mixed in to your own classes, but in many cases the simplest solution is to call the module function and pass your data, subject, and preferred algorithm (optional) in.

Data must be in the form of a nested hash. Example:

```ruby
books = {
  alice: {"War and Peace" => 2.5, "Crime and Punishment" => 3.5},
  bob: {"War of the Worlds" => 5.0, "War and Peace" => 1.5, "The Great Gatsby" => 4.0},
  cindy: {"War and Peace" => 5.0, "The Great Gatsby" => 4.5, "War of the Worlds" => 3.0, "Twenty Thousand Leagues Under the Sea" => 3.0},
  don: {"War of the Worlds" => 4.0, "The Great Gatsby" => 2.5, "Twenty Thousand Leagues Under the Sea" => 5.0, "Crime and Punishment" => 4.5, "War and Peace" => 3.0},
  erica: {"War of the Worlds" => 3.0, "The Great Gatsby" => 4.5, "Twenty Thousand Leagues Under the Sea" => 4.0, "Crime and Punishment" => 4.5, "War and Peace" => 3.5}}
```
### Recommendations

With the above 'data' in place, we can then call

```ruby
RecommEngine.recs(data: books, subject: :alice)
```

...which will return:

```ruby
[["Twenty Thousand Leagues Under the Sea", 4.5],
 ["The Great Gatsby", 3.5],
 ["War of the Worlds", 3.5]]
```

Only items the subject has not rated will be returned.  The second element in each array is the predicted score the subject will give to the item, based upon the weighted average that similar users to alice have rated the item.  Since no similarity algorithm was specified, the Pearson score is used by default.

Alternatively, we could specify the use of the Euclidean algorithm as follows.

```ruby
RecommEngine.recs(data: books, subject: :alice, similarity: 'Euclidean')
```

Which returns a similar, though subtly different set of results:

```ruby
[["Twenty Thousand Leagues Under the Sea", 4.182787296581158],
 ["War of the Worlds", 3.8959601003790714],
 ["The Great Gatsby", 3.7736808311188366]]
```

If you only want the top recommendation, simply:

```Ruby
RecommEngine.top_rec(data: books, subject: :alice, similarity: 'Euclidean')

### Similar Users

RecommEngine includes a utility to find similar users to a subject.  This can be done by calling:

```ruby
RecommEngine.similar_users(data: books, subject: :bob)
```

which returns:

```ruby
[[:don, 0.4539206495016016], [:alice, 0], [:erica, -0.09078412990032045]]
```

You'll notice a reasonably strong positive correlation with Don (meaning Don and Bob have similar taste), a neutral correlation with Alice, and a slightly negative correlation with Erica.

By default, the Pearson algorithm is used, and only 3 results are returned.  These  parameters can be defined explicitly when calling the method, by passing for example `num: 5` and/or `similarity: 'Euclidean'`.

To get users with the lowest similarity score: `RecommEngine.dissimilar_users(data: ...`

### Flipper

RecommEngine also provides a handy means to 'flip' your data -- transposing items and users.  This is most helpful when making generic item recommendations (for instance when a user is not logged in, or you do not have very much data for the logged-in user).  This can also be handy when pushing direct marketing campaigns for specific items.  Items are compared by similarity, and users are recommended for each items.  It can lead to some interesting results.  For example

```ruby
RecommEngine.recs(data: RecommEngine.flip(books), subject: 'Crime and Punishment')
```
returns

```ruby
[[:cindy, 5.0], [:bob, 1.5]]
```

## Contributing

Contributions are welcome; feel encouraged to fork the repo and submit PRs!  Current priorities include adding additional similarity algorithms and working more closely in conjunction with ActiveRecord to form our 'data' objects rather than explicitly declaring hashes.  Please ensure all specs pass before submitting a pull request is submitted, and be sure to add test coverage for any additional features.

## Questions?

codyknauer@gmail.com