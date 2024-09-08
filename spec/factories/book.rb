FactoryBot.define do
  factory :book do
    trait :with_isbn10 do
      isbn10 { IsbnKit.convert(isbn13) }
    end

    title { Faker::Book.title }
    isbn13 { Faker::Barcode.isbn }
    list_price { Faker::Number.between(from: 100, to: 10000) }
    publication_year { Faker::Number.between(from: 1500, to: Time.zone.today.year) }
    publisher { build(:publisher) }
    authors { build_list(:author, rand(1..3)) }
  end
end
