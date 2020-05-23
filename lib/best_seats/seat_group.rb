module BestSeats
  class SeatGroup
    attr_reader :sorted_seats

    def initialize(sorted_seats)
      @sorted_seats = sorted_seats
    end

    def consecutive_values?
      sorted_seats.delete_if.with_index do |value, index|
        if collection_end?(index)
          true
        else
          consecutive_value?(value, sorted_seats[index + 1])
        end
      end

      sorted_seats.empty?
    end

    private

    def consecutive_value?(value, next_value)
      value.next == next_value
    end

    def collection_end?(index)
      index >= last_index
    end

    def last_index
      sorted_seats.size - 1
    end
  end
end
