class SerializableBook < JSONAPI::Serializable::Resource
  type "books"

  attributes :id, :title, :isbn13, :isbn10, :list_price, :publication_year, :edition, :image_url # , :author_names, :publisher

  attribute :publisher do
    @object.publisher_name
  end

  attribute :authors do
    @object.author_names
  end
end
