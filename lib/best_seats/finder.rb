module BestSeats
  class Finder
    attr_reader :input, :seats_requested

    def initialize(input, seats_requested)
      @input = input
      @seats_requested = seats_requested
    end

    def all
      best_seats
    end

    private

    def best_seats
      selected_seats = []

      available_seats_matrix.each do |line|
        next if line.length < seats_requested
        return selected_seats.sort if selected_seats.length == seats_requested

        (0...seats_requested).each do |seat|
          index = index_to_remove(line)
          value = line.delete_at(index)
          selected_seats << value
        end

        first_element = selected_seats.first
        consecutive_values = [first_element]
        (0...seats_requested).each do |seat|
          consecutive_values << first_element.next
        end

        if selected_seats.sort == consecutive_values.sort
          return selected_seats
        end
      end

      selected_seats.sort
    end

    def available_seats_matrix
      matrix.map do |row|
        row.delete_if { |column| !seats.keys.include?(column) }
      end.delete_if(&:empty?)
    end

    def index_to_remove(collection)
      sorted = collection.sort
      mid = (sorted.length - 1) / 2.0
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
