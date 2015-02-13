require File.expand_path("../../lib/string_calculator", __FILE__)

describe StringCalculator do
  subject { described_class.new("string") }

  context "when expression is invalid" do
    context "when not closed by parentheses" do
      let(:exp) { "1 + 2" }

      it "raises error" do
        expect { described_class.new(exp).calculate }.to raise_error
      end
    end

    context "when there are more than two operands per expression" do
      let(:exp) { "(1 + 2 + 3)" }

      it "raises error" do
        expect { described_class.new(exp).calculate }.to raise_error
      end
    end

    context "when there is an operator on wrong side" do
      let (:exp) { "(-2 + 5)" }

      it "raises error" do
        expect { described_class.new(exp).calculate }.to raise_error
      end
    end
  end

  context "when expression is valid" do
    context "and not nested" do
      context do
        let(:exp) { "(1 + 2)" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(3)
        end
      end

      context do
        let(:exp) { "(5 - 2)" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(3)
        end
      end
    end

    context "and more nested" do
      context do
        let(:exp) { "(5 - (1 + 2))" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(2)
        end
      end

      context do
        let(:exp) { "((1 + 2) - 5)" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(-2)
        end
      end
    end

    context "and more more nested" do
      context do
        let(:exp) { "((5 + 7) - (1 + 2))" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(9)
        end
      end

      context do
        let(:exp) { "((5 - 7) - (1 + 2))" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(-5)
        end
      end

      context do
        let(:exp) { "(1 + ((2 + 1) + (4 - (9 - 2))))" }

        it "returns calculated value" do
          expect(described_class.new(exp).calculate).to eq(1)
        end
      end
    end
  end
end
