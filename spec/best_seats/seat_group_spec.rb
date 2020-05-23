require "best_seats/seat_group"

RSpec.describe BestSeats::SeatGroup do
  describe "#consecutive_values?" do
    context "when seats are consecutive" do
      let(:consecutive_seats) { [ "a1", "a2", "a3" ] }

      subject { described_class.new(consecutive_seats) }

      it "returns a positive result" do
        expect(subject.consecutive_values?).to eq(true)
      end
    end

    context "when seats are not consecutive" do
      let(:non_consecutive_seats) { [ "a1", "b2", "b3"] }

      subject { described_class.new(non_consecutive_seats) }

      it "returns a negative result" do
        expect(subject.consecutive_values?).to eq(false)
      end
    end
  end
end
