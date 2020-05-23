module BestSeats
  class BestSeatIndexFinder
    DENOMINATOR = 2.0

    attr_reader :collection_size

    def initialize(collection_size)
      @collection_size = collection_size
    end

    def call
      ((middle_position.floor + middle_position.ceil) / DENOMINATOR).to_i
    end

    private

    def middle_position
      @_middle_position ||= (collection_size - 1) / DENOMINATOR
    end
  end
end
