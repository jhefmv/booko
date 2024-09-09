require "rails_helper"

RSpec.describe "Books", type: :request do
  describe "GET /book/:isbn" do
    let(:show_url) { "/book" }
    let(:isbn13) { "978-1-60309-398-9" }
    let(:isbn10) { "1-60309-398-2" }
    let(:book) { create(:book, isbn13: isbn13, isbn10: isbn10) }

    [13, 10].each do |base|
      it "returns book information on a given ISBN-#{base}" do
        isbn = (base == 13) ? book.isbn13 : book.isbn10
        get "#{show_url}/#{isbn&.gsub(/([^0-9-])/, "")}"
        expect(response).to be_successful
        %i[title isbn13 list_price publication_year].each do |a|
          expect(response.body).to include(book.send(a).to_s)
        end
        expect(response.body).to include(book.publisher.name)
        expect(response.body).to include(book.author_names)
      end
    end

    context "when book does not exist" do
      it "returns error 404" do
        get "#{show_url}/4-19-830127-1"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when ISBN is invalid" do
      it "returns error 400" do
        get "#{show_url}/978-1-503.json"
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
