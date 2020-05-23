module BestSeats
  class Matrix
    INITIAL_ROW = "a"
    INITIAL_ROW_INDEX = 0
    INITIAL_COLUMN_INDEX = 1

    attr_reader :rows, :columns, :seats

    def initialize(rows, columns, seats)
      @rows = rows
      @columns = columns
      @seats = seats
    end

    def available
      return @_available if defined?(@_available)

      @_available = all.map do |row|
        row.select { |column| seats.keys.include?(column) }
      end.delete_if(&:empty?)
    end

    def all
      return @_full if defined?(@_full)

      row_letter = INITIAL_ROW

      @_full = (INITIAL_ROW_INDEX...rows).map.with_index do |row, index|
        row_letter = index.zero? ? INITIAL_ROW : row_letter.next

        (INITIAL_COLUMN_INDEX..columns).map do |column|
          "#{row_letter}#{column}".to_sym
        end
      end
    end
  end
end
