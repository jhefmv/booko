# README

Booko is a simple application for retrieving book information from a given ISBN-10 or ISBN-13. It also offers a JSON API to convert ISBN-10 to ISBN-13 or vice-versa. It runs on [Rails 7](https://rubyonrails.org/) with [Bootstrap 5](https://getbootstrap.com/) and [SQLite3](https://www.sqlite.org/) as the database.


## Requirements

* [Ruby](https://www.ruby-lang.org/en/documentation/installation/) version 3.3.4. [rbenv](https://github.com/rbenv/rbenv) can be installed to manage Ruby versions.

* [Ruby on Rails](https://rubyonrails.org/)

* [SQLite3](https://www.sqlite.org/)


## Installation
To install dependencies:

```
gem install bundler
bundle install
```

## Database preparation and creating initial books

To create tables initially and seed books:

```
bin/rails db:prepare db:seed
```

Alternatively, SQL Insert statements can be found in `db/sqlite3_dump.sql`

To drop, create database and create tables:

```
bin/rails db:drop db:create db:migrate
```

To import the dump file:

```
sqlite3 storage/development.sqlite3 < db/sqlite3_dump.sql
```

## Running locally

1. Start the Rails server by running the command: `bin/rails server`
2. Open a browser window and navigate to the link provided by `bin/rails server` command, usually http://127.0.0.1:3000

## Running tests

Unit and request tests are written in [RSpec](https://rspec.info/). To run them, issue any of the command:

```
bin/rspec spec --format=documentation
bundle exec rspec  spec --format=documentation
```


## Features

### Converting ISBN API

Make a POST HTTP request by passing a valid ISBN. Invalid ISBN will not be converted and the API will respond with successful status and an empty string.

```
POST /isbn/convert.json, { isbn: {value: "<ISBN-10 or ISBN-13>" } }
```

For example, given a ISBN-13 978-1-60309-398-9. the API will convert it to ISBN-10 1-60309-398-2 and vice-versa.

```
POST /isbn/convert.json, { isbn: {value: "ISBN13 978-1-60309-398-9" } }
```

```
POST /isbn/convert.json, { isbn: {value: "ISBN-10 1603093982" } }
```

### Retrieving book information API

Make a GET HTTP request and pass a valid ISBN-10 or ISBN-13.

```
GET /isbn/1603093982.json
```

```
GET /isbn/978-1-60309-398-9.json
```

Results:
```
{
  "data": {
    "id": "1",
    "type": "books",
    "attributes": 
      {"id": 1,
      "title": "American Elf",
      "isbn13": "978-1-891830-85-3",
      "isbn10": "1-891-83085-6",
      "list_price": "1000.0",
      "publication_year": 2004,
      "edition": "Book 2",
      "image_url": nil,
      "publisher": "Paste Magazine",
      "authors": "Joel  Hartse, Hannah P. Templer, Marguerite Z. Duras"
    }
  },
 "jsonapi": { "version": "1.0" }
}
```

If book does not exist, the API will respond with **404** status. If the ISBN is invalid, **400** error status will be returned.

### Front-end

- Search bar for navigating to book pages
- Hidden page (`/pages/isbn-convert`) for converting ISBN-13 to ISBN-10 (and vice versa)
