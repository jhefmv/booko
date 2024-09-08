require "rails_helper"

RSpec.describe IsbnKit, type: :helper do
  subject { described_class.new }

  let(:isbn13s) {
    ["ISBN 978-0-596-52068-7", "ISBN-13: 978-0-596-52068-7", "978 0 596 52068 7", "9780596520687"]
  }
  let(:isbn10s) {
    ["ISBN-10 0-596-52068-9", "0-596-52068-9", "0-9752298-0-X"]
  }

  describe ".isbn_valid?" do
    it "validates correctneses of the string" do
      isbn13s.dup.concat(isbn10s).each do |str|
        expect(described_class.isbn_valid?(str)).to be_truthy
      end

      [nil, "", "ISBN 978-0-596-52068-8", "ISBN-13: 978-0-596-52068-9", "978 0 596 52068 6",
        "9780596520685", "ISBN-10 0-596-52068-4", "0-596-52068-3", "978-1-891830-02-3"].each do |str|
        expect(described_class.isbn_valid?(str)).to be_falsy
      end
    end
  end

  describe ".to_isbn10" do
    it "converts ISBN-13 to ISBN-10 format" do
      ["ISBN 978-0-596-52068-7", "ISBN-13: 978-0-596-52068-7",
        "978 0 596 52068 7", "9780596520687"].each do |isbn|
        isbn10 = described_class.to_isbn10(isbn)
        expect(described_class.isbn_valid?(isbn10)).to be_truthy
        expect(isbn10).to eql("0-596-52068-9")
      end
    end

    context "when ISBN is invalid" do
      [nil, "978-0-596-52068-8", "ISBN-13: 979-8-886-45174-0", "978-8-886-45174-X"].each do |isbn|
        it "returns nil for ISBN #{isbn.nil? ? "nil" : isbn}" do
          expect(described_class.to_isbn10(isbn)).to be_nil
        end
      end
    end
  end

  describe ".to_isbn13" do
    it "converts ISBN-10 to ISBN-13 format" do
      ["ISBN-10 0-596-52068-9", "0-596-52068-9"].each do |isbn|
        isbn10 = described_class.to_isbn13(isbn)
        expect(described_class.isbn_valid?(isbn10)).to be_truthy
        expect(isbn10).to eql("978-0-596-52068-7")
      end

      expect(described_class.to_isbn13("0-9752298-0-X")).to eql("978-0-9752298-0-4")
    end

    context "when ISBN is invalid" do
      [
        [nil, "nil"],
        ["", "empty string"],
        ["ISBN-10 0-596-52068-8", "wrong check digit in"],
        ["0-596-5206-9", "too long"],
        ["0-596-520688-9", "too short"],
      ].each do |data|
        it "returns nil for #{data[1]} ISBN" do
          expect(described_class.to_isbn10(data[0])).to be_nil
        end
      end
    end
  end

  describe ".convert" do
    it "converts ISBN-13 to ISBN-10 format" do
      ["ISBN 978-0-596-52068-7", "ISBN-13: 978-0-596-52068-7",
        "978 0 596 52068 7", "9780596520687"].each do |isbn|
        isbn10 = described_class.convert(isbn)
        expect(described_class.isbn_valid?(isbn10)).to be_truthy
        expect(isbn10).to eql("0-596-52068-9")
      end
    end

    it "converts ISBN-10 to ISBN-13 format" do
      ["ISBN-10 0-596-52068-9", "0-596-52068-9"].each do |isbn|
        isbn10 = described_class.convert(isbn)
        expect(described_class.isbn_valid?(isbn10)).to be_truthy
        expect(isbn10).to eql("978-0-596-52068-7")
      end

      expect(described_class.to_isbn13("0-9752298-0-X")).to eql("978-0-9752298-0-4")
    end
  end
end
