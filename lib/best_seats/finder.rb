require "forwardable"
require "ostruct"
require "best_seats/matrix"
require "best_seats/best_seat_index_finder"
require "best_seats/seat_group"
require "best_seats/venue"

module BestSeats
  class Finder
    extend Forwardable

    DEFAULT_OPTIONS = {
      matrix_builder: BestSeats::Matrix,
      index_finder: BestSeats::BestSeatIndexFinder,
      venue_builder: BestSeats::Venue,
      seat_group: BestSeats::SeatGroup
    }.freeze
    INITIAL_SEAT_INDEX = 0

    attr_reader :input, :seats_requested

    def_delegators :venue,
      :rows,
      :columns,
      :seats
    def_delegators :options,
      :matrix_builder,
      :index_finder,
      :venue_builder,
      :seat_group

    def initialize(input, seats_requested, options = {})
      @input = input
      @seats_requested = seats_requested
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def all
      selected_seats = []

      available_seats_matrix.each do |line|
        next if insuficient_seats?(line.size)

        sorted_seats = selected_seats.sort

        return sorted_seats if all_seats_found?(sorted_seats)

        selected_seats = []

        (INITIAL_SEAT_INDEX...seats_requested).each do |seat|
          index = index_to_remove(line.size)
          value = line.delete_at(index)
          selected_seats << value
        end
      end

      selected_seats.sort
    end

    private

    def available_seats_matrix
      @_available_seats_matrix ||= matrix_builder.new(
        rows,
        columns,
        seats
      ).available
    end

    def insuficient_seats?(total)
      total < seats_requested
    end

    def all_seats_found?(selected_seats)
      enough_selected?(selected_seats.size) && consecutive_values?(selected_seats)
    end

    def enough_selected?(selected_count)
      selected_count == seats_requested
    end

    def consecutive_values?(seats)
      seat_group.new(
        seats.sort
      ).consecutive_values?
    end

    def index_to_remove(collection_size)
      index_finder.new(collection_size).call
    end

    def venue
      @_venue ||= venue_builder.new(input)
    end

    def options
      @_options ||= OpenStruct.new(@options)
    end
  end
end
