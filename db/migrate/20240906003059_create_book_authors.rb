class CreateBookAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :book_authors do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:book_authors, [ :book_id, :author_id ])
  end
end
