require "rails_helper"

RSpec.describe Author, type: :model do
  subject { described_class.new }

  describe "associations" do
    it { is_expected.to have_many(:books) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end
end
