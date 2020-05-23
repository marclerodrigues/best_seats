require "best_seats/finder"
require_relative "../support/files"

RSpec.describe BestSeats::Finder do
  describe "#all" do
    subject { described_class.new(input, seats_requested).all }

    context "when the input is a json file" do
      let(:input) { import_json_fixture("../fixtures/test.json") }
      let(:seats_requested) { 1 }

      it "returns the correct result" do
        expect(subject).to eq([:a1])
      end
    end

    context "when one seat is requested" do
      let(:seats_requested) { 1 }
      let(:input) do
        {
          "venue": {
            "layout": {
              "rows": 10,
              "columns": 50
            }
          },
          "seats": {
            "a1": {
              "id": "a1",
              "row": "a",
              "column": 1,
              "status": "AVAILABLE"
            },
            "b5": {
              "id": "b5",
              "row": "b",
              "column": 5,
              "status": "AVAILABLE"
            },
            "h7": {
              "id": "h7",
              "row": "h",
              "column": 7,
              "status": "AVAILABLE"
            }
          }
        }
      end

      it "returns the correct value" do
        expect(subject).to eq([:a1])
      end
    end

    context "when two seats are requested" do
      context "when first line has consecutive seats" do
        let(:seats_requested) { 2 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b2": {
                "id": "b2",
                "row": "b",
                "column": 2,
                "status": "AVAILABLE"
              },
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b4": {
                "id": "b4",
                "row": "b",
                "column": 4,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:b2, :b3])
        end
      end

      context "when first line doesn't have consecutive seats" do
        let(:seats_requested) { 2 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c2, :c3])
        end
      end

      context "when first line doesn't have enough seats" do
        let(:seats_requested) { 2 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c2, :c3])
        end
      end
    end

    context "when three seats are requested" do
      context "when first line has consecutive seats" do
        let(:seats_requested) { 3 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b2": {
                "id": "b2",
                "row": "b",
                "column": 2,
                "status": "AVAILABLE"
              },
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b4": {
                "id": "b4",
                "row": "b",
                "column": 4,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:b2, :b3, :b4])
        end
      end
      context "when first line doesn't have consecutive seats" do
        let(:seats_requested) { 3 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c2, :c3, :c4])
        end
      end

      context "when first line doesn't have enough seats" do
        let(:seats_requested) { 3 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b2": {
                "id": "b2",
                "row": "b",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c2, :c3, :c4])
        end
      end
    end

    context "when four seats are requested" do
      context "when first line has consecutive seats" do
        let(:seats_requested) { 4 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b2": {
                "id": "b2",
                "row": "b",
                "column": 2,
                "status": "AVAILABLE"
              },
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b4": {
                "id": "b4",
                "row": "b",
                "column": 4,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:b1, :b2, :b3, :b4])
        end
      end

      context "when first line doesn't have consecutive seats" do
        let(:seats_requested) { 4 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b3": {
                "id": "b3",
                "row": "b",
                "column": 3,
                "status": "AVAILABLE"
              },
              "b4": {
                "id": "b4",
                "row": "b",
                "column": 4,
                "status": "AVAILABLE"
              },
              "b5": {
                "id": "b5",
                "row": "b",
                "column": 5,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c1, :c2, :c3, :c4])
        end
      end

      context "when first line doesn't have consecutive seats" do
        let(:seats_requested) { 4 }
        let(:input) do
          {
            "venue": {
              "layout": {
                "rows": 10,
                "columns": 5
              }
            },
            "seats": {
              "b1": {
                "id": "b1",
                "row": "b",
                "column": 1,
                "status": "AVAILABLE"
              },
              "b2": {
                "id": "b2",
                "row": "b",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c1": {
                "id": "c1",
                "row": "c",
                "column": 1,
                "status": "AVAILABLE"
              },
              "c2": {
                "id": "c2",
                "row": "c",
                "column": 2,
                "status": "AVAILABLE"
              },
              "c3": {
                "id": "c3",
                "row": "c",
                "column": 3,
                "status": "AVAILABLE"
              },
              "c4": {
                "id": "c4",
                "row": "c",
                "column": 4,
                "status": "AVAILABLE"
              },
              "c5": {
                "id": "c5",
                "row": "c",
                "column": 5,
                "status": "AVAILABLE"
              }
            }
          }
        end

        it "returns the correct value" do
          expect(subject).to eq([:c1, :c2, :c3, :c4])
        end
      end
    end
  end
end
