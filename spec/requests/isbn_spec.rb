require "rails_helper"

RSpec.describe "ISBN", type: :request do
  let(:isbn13) { "978-1-60309-398-9" }
  let(:isbn10) { "1-60309-398-2" }
  let(:isbn_url) { "/isbn" }

  describe "POST /convert" do
    let(:convert_url) { "#{isbn_url}/convert.json" }

    it "converts ISBN-13 to ISBN-10 format" do
      allow(IsbnKit).to receive(:convert).with(isbn13) { isbn10 }
      post convert_url, params: { isbn: { value: isbn13 } }
      expect(response).to be_successful
      expect(response.body).to eql(isbn10)
      expect(IsbnKit).to have_received(:convert).with(isbn13)
    end

    it "converts ISBN-10 to ISBN-13 format" do
      allow(IsbnKit).to receive(:convert).with(isbn10) { isbn13 }
      post convert_url, params: { isbn: { value: isbn10 } }
      expect(response).to be_successful
      expect(response.body).to eql(isbn13)
      expect(IsbnKit).to have_received(:convert).with(isbn10)
    end

    context "when ISBN is invalid" do
      [
        ["", "empty input"],
        ["ISBN-10 0-596-52068-8", "ISBN with wrong check digit"],
        ["0-596-5206-9", "input value that is too long"],
        ["0-596-520688-9", "input value that is too short"],
      ].each do |data|
        it "returns nothing for #{data[1]}" do
          post convert_url, params: { isbn: { value: data[0] } }
          expect(response).to be_successful
          expect(response.body).to be_empty
        end
      end
    end
  end

  describe "GET /show" do
    let(:show_url) { isbn_url }
    let(:book) { create(:book, isbn13: isbn13, isbn10: isbn10) }

    [13, 10].each do |base|
      it "returns book information on a given ISBN-#{base}" do
        isbn = (base == 13) ? book.isbn13 : book.isbn10
        get "#{show_url}/#{isbn&.gsub(/([^0-9-])/, "")}.json"
        book_response = JSON.parse(response.body).dig("data", "attributes")
        expect(response).to be_successful
        book.attributes.except("list_price", "publisher_id", "created_at", "updated_at").each do |a|
          expect(book_response.dig(a[0])).to eql(a[1])
        end
        expect(book_response["list_price"]).to eql(book.list_price.to_s)
        expect(book_response["publisher"]).to eql(book.publisher_name)
        expect(book_response["authors"]).to eql(book.author_names)
      end
    end

    context "when book does not exist" do
      it "returns error 404" do
        get "#{show_url}/4-19-830127-1.json"
        expect(response.body).to include("Book not found")
        expect(response).to be_not_found
      end
    end

    context "when ISBN is invalid" do
      it "returns error 400" do
        get "#{show_url}/978-1-60309.json"
        expect(response.body).to include("ISBN is not valid")
        expect(response).to be_bad_request
      end
    end
  end
end
