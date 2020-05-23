require "best_seats/best_seat_index_finder"

RSpec.describe BestSeats::BestSeatIndexFinder do
  describe "#call" do
    subject { described_class.new(collection_size).call }

    context "when collection size is 1" do
      let(:collection_size) { 1 }
      let(:best_seat_index) { 0 }

      it "returns the correct seat index" do
        expect(subject).to eq(best_seat_index)
      end
    end

    context "when collection size is 2" do
      let(:collection_size) { 2 }
      let(:best_seat_index) { 0 }

      it "returns the correct seat index" do
        expect(subject).to eq(best_seat_index)
      end
    end

    context "when collection size is 3" do
      let(:collection_size) { 3 }
      let(:best_seat_index) { 1 }

      it "returns the correct seat index" do
        expect(subject).to eq(best_seat_index)
      end
    end

    context "when collection size is 4" do
      let(:collection_size) { 4 }
      let(:best_seat_index) { 1 }

      it "returns the correct seat index" do
        expect(subject).to eq(best_seat_index)
      end
    end

    context "when collection size is 5" do
      let(:collection_size) { 5 }
      let(:best_seat_index) { 2 }

      it "returns the correct seat index" do
        expect(subject).to eq(best_seat_index)
      end
    end
  end
end
