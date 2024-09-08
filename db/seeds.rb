# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Publishers
[
  "Paste Magazine", "Publishers Weekly", "Graywolf Press",
  "Graywolf Press", "McSweeney's",
].each do |p|
    Publisher.find_or_create_by!(name: p)
end

# Authors
authors = {
  "Joel Hartse" => {first_name: "Joel", last_name: "Hartse"},
  "Hannah P. Templer" => {first_name: "Hannah", middle_name: "P.", last_name: "Templer"},
  "Marguerite Z. Duras" => {first_name: "Marguerite", middle_name: "Z.", last_name: "Duras"},
  "Kingsley Amis" => {first_name: "Kingsley", last_name: "Amis"},
  "Fannie Peters Flagg" => {first_name: "Fannie", middle_name: "Peters", last_name: "Flagg"},
  "Camille Byron Paglia" => {first_name: "Camille", middle_name: "Byron", last_name: "Paglia"},
  "Rainer Steel Rilke" => {first_name: "Rainer", middle_name: "Steel", last_name: "Rilke"},
}
authors.each do |name, a|
  unless Author.find_by(a)
    Author.create!(a)
  end
end

# Books
[
  {
    title: "American Elf", isbn13: "978-1-891830-85-3", isbn10: "1-891-83085-6",
    publication_year: 2004, publisher: "Paste Magazine", edition: "Book 2", list_price: 1000,
    authors: [
      "Joel Hartse", "Hannah P. Templer", "Marguerite Z. Duras"
    ]
  },
  {
    title: "Cosmoknights", isbn13: "978-1-60309-454-2", isbn10: "1-603-09454-7",
    publication_year: 2019, publisher: "Publishers Weekly", edition: "Book 1", list_price: 2000,
    authors: ["Kingsley Amis"]
  },
  {
    title: "Essex County", isbn13: "978-1-60309-038-4", isbn10: "1-603-09038-X",
    publication_year: 1990, publisher: "Graywolf Press", edition: "", list_price: 500,
    authors: ["Kingsley Amis"]
  },
  {
    title: "Hey, Mister (Vol 1)", isbn13: "978-1-891830-02-0", isbn10: "1-891-83002-3",
    publication_year: 2000, publisher: "Graywolf Press", edition: "After School Special", list_price: 1200,
    authors: ["Hannah P. Templer", "Fannie Peters Flagg", "Camille Byron Paglia"]
  },
  {
    title: "The Underwater Welder", isbn13: "978-1-60309-398-9", isbn10: "1-60309-398-2",
    publication_year: 2022, publisher: "McSweeney's", edition: "", list_price: 3000,
    authors: ["Rainer Steel Rilke"]
  },
  
].each do |b|
  unless Book.find_by(title: b[:title])
    book = Book.new(b.except(:publisher, :authors))
    book.publisher = Publisher.find_by(name: b[:publisher])
    book.authors = b[:authors].map do |a|
      Author.find_by(authors[a])
    end
    book.save!
  end
end
