require "best_seats/matrix"

RSpec.describe BestSeats::Matrix do
  let(:seats) do
    {
      :a1 => {
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      }
    }
  end

  subject { described_class.new(rows, columns, seats) }

  describe "#available" do
    let(:rows) { 2 }
    let(:columns) { 2 }

    it "returns only the available seats matrix" do
      expected_matrix = [
        [:a1]
      ]

      expect(subject.available).to eq(expected_matrix)
    end
  end

  describe "#all" do
    context "when matrix is 2x2" do
      let(:rows) { 2 }
      let(:columns) { 2 }

      it "returns the correct matrix with all seats" do
        expected_matrix = [
          [:a1, :a2],
          [:b1, :b2]
        ]

        expect(subject.all).to eq(expected_matrix)
      end
    end

    context "when matrix is 3x2" do
      let(:rows) { 3 }
      let(:columns) { 2 }

      it "returns the correct matrix with all seats" do
        expected_matrix = [
          [:a1, :a2],
          [:b1, :b2],
          [:c1, :c2]
        ]

        expect(subject.all).to eq(expected_matrix)
      end
    end

    context "when matrix is 2x3" do
      let(:rows) { 2 }
      let(:columns) { 3 }

      it "returns the correct matrix with all seats" do
        expected_matrix = [
          [:a1, :a2, :a3],
          [:b1, :b2, :b3]
        ]

        expect(subject.all).to eq(expected_matrix)
      end
    end
  end
end
