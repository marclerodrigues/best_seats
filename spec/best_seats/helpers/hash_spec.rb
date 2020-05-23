require "best_seats/helpers/hash"

RSpec.describe BestSeats::Helpers::Hash do
  describe ".deep_symbolize_keys" do
    subject { described_class.deep_symbolize_keys(hash) }

    context "when hash doesn't contain nested hashes" do
      let(:hash) do
        {
          "a" => [],
          "b" => true,
          "c" => "a",
          "d" => 1
        }
      end
      let(:expected_hash) do
        {
          a: [],
          b: true,
          c: "a",
          d: 1
        }
      end

      it "converts all keys to symbol" do
        expect(subject).to eq(expected_hash)
      end
    end

    context "when hash contains nested hashes" do
      context "with one level of nesting" do
        let(:hash) do
          {
            "a" => {
              "level" => 1
            },
            "b" => true,
            "c" => "a",
            "d" => 1
          }
        end
        let(:expected_hash) do
          {
            a: {
              level: 1
            },
            b: true,
            c: "a",
            d: 1
          }
        end

        it "converts all keys to symbol" do
          expect(subject).to eq(expected_hash)
        end
      end

      context "with one level of nesting" do
        let(:hash) do
          {
            "a" => {
              "level" => 1,
              "new_level" =>  {
                "level" => 2
              }
            },
            "b" => true,
            "c" => "a",
            "d" => 1
          }
        end
        let(:expected_hash) do
          {
            a: {
              level: 1,
              new_level: {
                level: 2
              }
            },
            b: true,
            c: "a",
            d: 1
          }
        end

        it "converts all keys to symbol" do
          expect(subject).to eq(expected_hash)
        end
      end
    end
  end
end
