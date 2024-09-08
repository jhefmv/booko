require "rails_helper"

RSpec.describe BookAuthor, type: :model do
  subject { described_class.new }

  describe "associations" do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:author) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:author) }
  end
end
