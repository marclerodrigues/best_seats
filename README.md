# BestSeats

Find the best seats from a list of open seats from a given venue.


## Challenge

Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.

The list of open seats, number of rows and columns (seats) is based on a JSON input.

```json
{
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 50
    }
  },
  "seats": {
    "a1": {
      "id": "a1",
      "row": "a",
      "column": 1,
      "status": "AVAILABLE"
    },
    "b5": {
      "id": "b5",
      "row": "b",
      "column": 5,
      "status": "AVAILABLE"
    },
    "h7": {
      "id": "h7",
      "row": "h",
      "column": 7,
      "status": "AVAILABLE"
    }
  }
}
```

The solution should find the best open seat (closest to the front & middle) given the input JSON and number of requested seats. Imagine a concert, people want to be as close as possible to the stage.

For example, for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6.

If a group of seats is requested, the algorithm needs to find the best open group of seats together. In the example above, for 3 seats, it would be A5, A6, and A7.

For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'best_seats'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install best_seats

## Usage

The algorithm works either with a JSON or a Ruby Hash.

```ruby
require "best_seats/finder"

file = File.read("file_path")
input = JSON.parse(file)
seats_requested = 1

finder = BestSeats::Finder.new(input, seats_requested)
finder.all

# => [:a1]
```
```ruby
require "best_seats/finder"

input = {
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 5
    }
  },
  "seats": {
    "a1": {
      "id": "a1",
      "row": "a",
      "column": 1,
      "status": "AVAILABLE"
    },
    "b5": {
      "id": "b5",
      "row": "b",
      "column": 5,
      "status": "AVAILABLE"
    },
    "h7": {
      "id": "h7",
      "row": "h",
      "column": 7,
      "status": "AVAILABLE"
    }
  }
}
seats_requested = 1

finder = BestSeats::Finder.new(input, seats_requested)
finder.all

# => [:a1]
```

You can also pass a hash of options to customize the behavior:
```ruby
require "best_seats/finder"

file = File.read("file_path")
input = JSON.parse(file)
seats_requested = 1
options = {
  index_finder: MyCustomIndexFinder
}

finder = BestSeats::Finder.new(input, seats_requested, options)
finder.all

# => [:a1]
```
Available options:
```ruby
DEFAULT_OPTIONS = {
  matrix_builder: BestSeats::Matrix,
  index_finder: BestSeats::BestSeatIndexFinder,
  venue_builder: BestSeats::Venue,
  seat_group: BestSeats::SeatGroup
}.freeze
```

`matrix_builder` - Customize how to build the available seats matrix, check the original class to see the required interface.

`index_finder` - Customize how to find the best seat index, check the original class to see the required interface.

`venue_builder` - Builds the venues from the JSON input, this way you can accept other input formats. Check the original class to the required interface.

`seat_group` - Find if seats are consecutive, check the orignal class to see the required interface.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marclerodrigues/best_seats.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
