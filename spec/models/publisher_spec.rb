require "rails_helper"

RSpec.describe Publisher, type: :model do
  subject { described_class.new }

  describe "associations" do
    it { is_expected.to have_many(:books) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
