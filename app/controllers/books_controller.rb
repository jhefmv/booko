class BooksController < ApplicationController
  # def show_by_isbn
  def show
    @book = get_book_by_isbn
    @book || raise(ActiveRecord::RecordNotFound)
  end

  private

  def get_book_by_isbn
    isbn = params[:isbn]
    if IsbnKit.isbn_valid?(isbn)
      book_table = Book.arel_table
      book_arel = book_table[:isbn13].matches(isbn).or(book_table[:isbn10].matches(isbn))
      books = Book.where(book_arel)
      if books.exists?
        @book = books.first
      end
    end
  end
end
