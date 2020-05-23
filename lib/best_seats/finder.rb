module BestSeats
  class Finder
    attr_reader :input, :seats_requested

    def initialize(input, seats_requested)
      @input = input
      @seats_requested = seats_requested
    end

    def all
      selected_seats = []

      available_seats_matrix.each do |line|
        next if insuficient_seats?(line.size)
        return selected_seats.sort if enough_selected?(selected_seats.size) && consecutive_values?(selected_seats)

        selected_seats = []

        (0...seats_requested).each do |seat|
          index = index_to_remove(line)
          value = line.delete_at(index)
          selected_seats << value
        end
      end

      selected_seats.sort
    end

    private

    def available_seats_matrix
      matrix.map do |row|
        row.delete_if { |column| !seats.keys.include?(column) }
      end.delete_if(&:empty?)
    end

    def insuficient_seats?(total)
      total < seats_requested
    end

    def enough_selected?(selected_count)
      selected_count == seats_requested
    end

    def consecutive_values?(selected_seats)
      sorted_values = selected_seats.sort
      size = sorted_values.size

      sorted_values.delete_if.with_index do |value, index|
        if index < size - 1
          value.next == sorted_values[index+1]
        else
          true
        end
      end

      sorted_values.empty?
    end

    def index_to_remove(collection)
      sorted = collection.sort
      mid = (sorted.size - 1) / 2.0
      ((mid.floor + mid.ceil) / 2.0).to_i
    end

    def matrix
      return @_matrix if defined?(@_matrix)

      row_letter = "a"

      @_matrix = (0...rows).map.with_index do |row, index|
        row_letter = index.zero? ? "a" : row_letter.next

        (1..columns).map do |column|
          "#{row_letter}#{column}".to_sym
        end
      end
    end

    def rows
      @_rows ||= input.dig(:venue, :layout, :rows)
    end

    def columns
      @_columns ||= input.dig(:venue, :layout, :columns)
    end

    def seats
      @_seats ||= input.dig(:seats)
    end
  end
end
