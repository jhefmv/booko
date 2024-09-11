require "rails_helper"

RSpec.describe "ISBN Search bar", type: :system, js: true do
  it "presents a form" do
    visit root_path

    expect(page).to have_field("Search", id: "isbn", placeholder: "Search")
  end

  it "validates the ISBN input" do
    visit root_path
    fill_in "isbn", with: "978-1-891830-85-2"
    find("#isbn").native.send_keys(:return)

    expect(page).to have_content("Invalid ISBN")
  end

  context "when book does not exist" do
    it "shows error message" do
      visit root_path
      fill_in "isbn", with: "978-3-16-148410-0"
      find("#isbn").native.send_keys(:return)

      expect(page).to have_content("Book not found")
    end
  end

  it "redirects to book page" do
    book = create(:book)
    visit root_path
    fill_in "isbn", with: book.isbn13
    find("#isbn").native.send_keys(:return)

    %i[title isbn13 list_price publication_year].each do |a|
      expect(page).to have_content(book.send(a).to_s)
    end
    expect(page).to have_content(book.publisher.name)
    expect(page).to have_content("by #{book.author_names}")
  end
end
