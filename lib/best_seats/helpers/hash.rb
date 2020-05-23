module BestSeats
  module Helpers
    class Hash
      def self.deep_symbolize_keys(hash)
        new.deep_symbolize_keys(hash)
      end

      def deep_symbolize_keys(hash)
        hash.inject({}) do |memo,(key, value)|
          if value.is_a?(::Hash)
            memo[key.to_sym] = deep_symbolize_keys(value)
          else
            memo[key.to_sym] = value
          end
          memo
        end
      end
    end
  end
end
