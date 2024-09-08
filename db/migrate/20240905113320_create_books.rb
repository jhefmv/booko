class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn13
      t.string :isbn10
      t.decimal :list_price, precision: 10, scale: 2
      t.integer :publication_year, limit: 4
      t.string :edition
      t.string :image_url
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:books, :isbn13, unique: true)
    add_index(:books, :isbn10, unique: true)
  end
end
