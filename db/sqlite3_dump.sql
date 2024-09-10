PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "publishers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO publishers VALUES(1,'Paste Magazine','2024-09-10 04:14:10.896312','2024-09-10 04:14:10.896312');
INSERT INTO publishers VALUES(2,'Publishers Weekly','2024-09-10 04:14:10.908039','2024-09-10 04:14:10.908039');
INSERT INTO publishers VALUES(3,'Graywolf Press','2024-09-10 04:14:10.916094','2024-09-10 04:14:10.916094');
INSERT INTO publishers VALUES(4,'McSweeney''s','2024-09-10 04:14:10.928339','2024-09-10 04:14:10.928339');
CREATE TABLE IF NOT EXISTS "authors" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar NOT NULL, "middle_name" varchar, "last_name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO authors VALUES(1,'Joel',NULL,'Hartse','2024-09-10 04:14:10.945608','2024-09-10 04:14:10.945608');
INSERT INTO authors VALUES(2,'Hannah','P.','Templer','2024-09-10 04:14:10.951407','2024-09-10 04:14:10.951407');
INSERT INTO authors VALUES(3,'Marguerite','Z.','Duras','2024-09-10 04:14:10.956901','2024-09-10 04:14:10.956901');
INSERT INTO authors VALUES(4,'Kingsley',NULL,'Amis','2024-09-10 04:14:10.980448','2024-09-10 04:14:10.980448');
INSERT INTO authors VALUES(5,'Fannie','Peters','Flagg','2024-09-10 04:14:10.991428','2024-09-10 04:14:10.991428');
INSERT INTO authors VALUES(6,'Camille','Byron','Paglia','2024-09-10 04:14:11.001916','2024-09-10 04:14:11.001916');
INSERT INTO authors VALUES(7,'Rainer','Steel','Rilke','2024-09-10 04:14:11.009283','2024-09-10 04:14:11.009283');
CREATE TABLE IF NOT EXISTS "books" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "isbn13" varchar NOT NULL, "isbn10" varchar, "list_price" decimal(10,2) NOT NULL, "publication_year" integer(4) NOT NULL, "edition" varchar, "image_url" varchar, "publisher_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_d7ae2b039e"
FOREIGN KEY ("publisher_id")
  REFERENCES "publishers" ("id")
);
INSERT INTO books VALUES(1,'American Elf','978-1-891830-85-3','1-891-83085-6',1000,2004,'Book 2',NULL,1,'2024-09-10 04:14:11.100866','2024-09-10 04:14:11.100866');
INSERT INTO books VALUES(2,'Cosmoknights','978-1-60309-454-2','1-603-09454-7',2000,2019,'Book 1',NULL,2,'2024-09-10 04:14:11.131375','2024-09-10 04:14:11.131375');
INSERT INTO books VALUES(3,'Essex County','978-1-60309-038-4','1-603-09038-X',500,1990,'',NULL,3,'2024-09-10 04:14:11.145283','2024-09-10 04:14:11.145283');
INSERT INTO books VALUES(4,'Hey, Mister (Vol 1)','978-1-891830-02-0','1-891-83002-3',1200,2000,'After School Special',NULL,3,'2024-09-10 04:14:11.161385','2024-09-10 04:14:11.161385');
INSERT INTO books VALUES(5,'The Underwater Welder','978-1-60309-398-9','1-60309-398-2',3000,2022,'',NULL,4,'2024-09-10 04:14:11.181262','2024-09-10 04:14:11.181262');
CREATE TABLE IF NOT EXISTS "book_authors" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "book_id" integer NOT NULL, "author_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_b23f3934c1"
FOREIGN KEY ("book_id")
  REFERENCES "books" ("id")
, CONSTRAINT "fk_rails_0c0759568d"
FOREIGN KEY ("author_id")
  REFERENCES "authors" ("id")
);
INSERT INTO book_authors VALUES(1,1,1,'2024-09-10 04:14:11.103236','2024-09-10 04:14:11.103236');
INSERT INTO book_authors VALUES(2,1,2,'2024-09-10 04:14:11.105252','2024-09-10 04:14:11.105252');
INSERT INTO book_authors VALUES(3,1,3,'2024-09-10 04:14:11.107045','2024-09-10 04:14:11.107045');
INSERT INTO book_authors VALUES(4,2,4,'2024-09-10 04:14:11.133580','2024-09-10 04:14:11.133580');
INSERT INTO book_authors VALUES(5,3,4,'2024-09-10 04:14:11.146910','2024-09-10 04:14:11.146910');
INSERT INTO book_authors VALUES(6,4,2,'2024-09-10 04:14:11.162960','2024-09-10 04:14:11.162960');
INSERT INTO book_authors VALUES(7,4,5,'2024-09-10 04:14:11.164480','2024-09-10 04:14:11.164480');
INSERT INTO book_authors VALUES(8,4,6,'2024-09-10 04:14:11.165972','2024-09-10 04:14:11.165972');
INSERT INTO book_authors VALUES(9,5,7,'2024-09-10 04:14:11.182860','2024-09-10 04:14:11.182860');
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('publishers',4);
INSERT INTO sqlite_sequence VALUES('authors',7);
INSERT INTO sqlite_sequence VALUES('books',5);
INSERT INTO sqlite_sequence VALUES('book_authors',9);
CREATE UNIQUE INDEX "index_publishers_on_name" ON "publishers" ("name");
CREATE INDEX "index_books_on_publisher_id" ON "books" ("publisher_id");
CREATE UNIQUE INDEX "index_books_on_isbn13" ON "books" ("isbn13");
CREATE UNIQUE INDEX "index_books_on_isbn10" ON "books" ("isbn10");
CREATE INDEX "index_book_authors_on_book_id" ON "book_authors" ("book_id");
CREATE INDEX "index_book_authors_on_author_id" ON "book_authors" ("author_id");
CREATE INDEX "index_book_authors_on_book_id_and_author_id" ON "book_authors" ("book_id", "author_id");
COMMIT;
