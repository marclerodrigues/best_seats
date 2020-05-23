require "best_seats/helpers/hash"

module BestSeats
  class Venue
    def initialize(params)
      @params = params
    end

    def rows
      @_rows ||= layout.dig(:rows)
    end

    def columns
      @_column ||= layout.dig(:columns)
    end

    def seats
      @_seats ||= params.dig(:seats)
    end

    private

    def layout
      @_layout ||= params.dig(:venue, :layout)
    end

    def params
      @_params ||= ::BestSeats::Helpers::Hash.deep_symbolize_keys(@params)
    end
  end
end
