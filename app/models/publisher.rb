class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { uniqueness: true, case_sensitive: false }
end
