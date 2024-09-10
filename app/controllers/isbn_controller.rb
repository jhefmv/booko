class IsbnController < ApplicationApiController
  around_action :catch_errors

  # POST /isbn/convert
  def convert
    render json: IsbnKit.convert(isbn_params[:value]) || ""
  end

  # GET /isbn/:isbn
  def show
    isbn = params[:isbn]
    if IsbnKit.isbn_valid?(isbn)
      book_table = Book.arel_table
      book_arel = book_table[:isbn13].matches(isbn).or(book_table[:isbn10].matches(isbn))
      book = Book.where(book_arel).first
      if book.present?
        render jsonapi: book, root: "book"
      else
        render json: { error: "Book not found" }, status: :not_found
      end
    else
      render json: { error: "ISBN is not valid" }, status: :bad_request
    end
  end

  private

  def isbn_params
    params.require(:isbn).permit(:value)
  end

  def catch_errors
    Rails.error.record do
      yield
    end
  end
end
