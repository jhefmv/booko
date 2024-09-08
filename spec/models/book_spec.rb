require "rails_helper"

RSpec.describe Book, type: :model do
  subject { described_class.new }

  describe "associations" do
    it { is_expected.to belong_to(:publisher) }
    it { is_expected.to have_many(:authors) }
  end

  describe "validations" do
    subject { build(:book) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:isbn13) }
    it { is_expected.to validate_uniqueness_of(:isbn13).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:isbn10).case_insensitive }
    it { is_expected.to validate_presence_of(:list_price) }
    it { is_expected.to validate_presence_of(:publication_year) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_presence_of(:authors) }

    it "validates correctneses of isbn13" do
      subject { described_class.new }
      ["ISBN 978-0-596-52068-7", "ISBN-13: 978-0-596-52068-7", "978 0 596 52068 7",
        "978-1-891830-02-0", "9780596520687"].each do |str|
        subject.isbn13 = str
        expect(IsbnKit.isbn_valid?(subject.isbn13)).to be_truthy
        expect(subject).to be_valid
      end
    end

    it "validates correctneses of isbn10" do
      ["ISBN-10 0-596-52068-9", "0-596-52068-9", "0-9752298-0-X"].each do |str|
        subject.isbn10 = str
        expect(IsbnKit.isbn_valid?(subject.isbn10)).to be_truthy
        expect(subject).to be_valid
      end
    end
  end
end
