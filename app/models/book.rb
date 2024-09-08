class Book < ApplicationRecord
  include IsbnKit

  belongs_to :publisher
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors

  validates :title, :isbn13, :list_price, :publication_year, :publisher, :authors, presence: true
  validates :isbn13, :isbn10, uniqueness: { uniqueness: true, case_sensitive: false }
  validate :isbn13_correctness, :isbn10_correctness

  def publisher_name
    publisher&.name
  end

  def author_names
    authors&.map { |a| [a.first_name, a.middle_name, a.last_name].join(" ") }&.join(", ")
  end

  def isbn13_correctness
    return if isbn13.nil?

    unless IsbnKit.isbn_valid?(isbn13)
      errors.add(:isbn13, "is not valid ISBN-13 format")
    end
  end

  def isbn10_correctness
    return if isbn10.nil?

    unless IsbnKit.isbn_valid?(isbn10)
      errors.add(:isbn10, "is not valid ISBN-10 format")
    end
  end
end
