require "best_seats/venue"
require_relative "../support/files"

RSpec.describe BestSeats::Venue do
  context "when params come from a json input" do
    let(:json_file) { import_json_fixture("../fixtures/test.json") }
    let(:venue_params) { json_file }
    let(:seats) do
      {
        a1: {
          "id": "a1",
          "row": "a",
          "column": 1,
          "status": "AVAILABLE"
        },
        b5: {
          "id": "b5",
          "row": "b",
          "column": 5,
          "status": "AVAILABLE"
        },
        h7: {
          "id": "h7",
          "row": "h",
          "column": 7,
          "status": "AVAILABLE"
        }
      }
    end

    subject { described_class.new(venue_params) }

    describe "#rows" do
      it "returns number of rows" do
        expect(subject.rows).to eq(10)
      end
    end

    describe "#columns" do
      it "returns number of rows" do
        expect(subject.columns).to eq(50)
      end
    end

    describe "#seats" do
      it "returns the correct seats" do
        expect(subject.seats).to eq(seats)
      end
    end
  end

  context "when params come from a ruby hash" do
    let(:layout) do
      {
        rows: 5,
        columns: 5,
      }
    end
    let(:seats) do
      {
        a1: {
          id: "a1",
          row: "a",
          column: 1,
          status: "AVAILABLE"
        }
      }
    end

    let(:venue_params) do
      {
        venue: {
          layout: layout
        },
        seats: seats
      }
    end

    subject { described_class.new(venue_params) }

    describe "#rows" do
      it "returns number of rows" do
        expect(subject.rows).to eq(5)
      end
    end

    describe "#columns" do
      it "returns number of rows" do
        expect(subject.columns).to eq(5)
      end
    end

    describe "#seats" do
      it "returns the correct seats" do
        expect(subject.seats).to eq(seats)
      end
    end
  end
end
