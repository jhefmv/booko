PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "publishers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO publishers VALUES(1,'Paste Magazine','2024-09-06 11:24:00.369128','2024-09-06 11:24:00.369128');
INSERT INTO publishers VALUES(2,'Publishers Weekly','2024-09-06 11:24:00.428615','2024-09-06 11:24:00.428615');
INSERT INTO publishers VALUES(3,'Graywolf Press','2024-09-06 11:24:00.435965','2024-09-06 11:24:00.435965');
INSERT INTO publishers VALUES(4,'McSweeney''s','2024-09-06 11:24:00.443219','2024-09-06 11:24:00.443219');
CREATE TABLE IF NOT EXISTS "authors" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar, "middle_name" varchar, "last_name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO authors VALUES(1,'Joel',NULL,'Hartse','2024-09-06 11:47:37.815261','2024-09-06 11:47:37.815261');
INSERT INTO authors VALUES(2,'Hannah','P.','Templer','2024-09-06 11:47:37.880184','2024-09-06 11:47:37.880184');
INSERT INTO authors VALUES(3,'Marguerite','Z.','Duras','2024-09-06 11:47:37.884936','2024-09-06 11:47:37.884936');
INSERT INTO authors VALUES(4,'Kingsley',NULL,'Amis','2024-09-06 11:47:37.889721','2024-09-06 11:47:37.889721');
INSERT INTO authors VALUES(5,'Fannie','Peters','Flagg','2024-09-06 11:47:37.894388','2024-09-06 11:47:37.894388');
INSERT INTO authors VALUES(6,'Camille','Byron','Paglia','2024-09-06 11:47:37.899018','2024-09-06 11:47:37.899018');
INSERT INTO authors VALUES(7,'Rainer','Steel','Rilke','2024-09-06 11:47:37.914922','2024-09-06 11:47:37.914922');
CREATE TABLE IF NOT EXISTS "books" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "isbn13" varchar, "isbn10" varchar, "list_price" decimal(10,2), "publication_year" integer(4), "edition" varchar, "image_url" varchar, "publisher_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_d7ae2b039e"
FOREIGN KEY ("publisher_id")
  REFERENCES "publishers" ("id")
);
INSERT INTO books VALUES(1,'American Elf','978-1-891830-85-3','1-891-83085-6',1000,2004,'Book 2',NULL,1,'2024-09-06 11:54:27.787181','2024-09-06 11:54:27.787181');
INSERT INTO books VALUES(2,'Cosmoknights','978-1-60309-454-2','1-603-09454-7',2000,2019,'Book 1',NULL,2,'2024-09-06 11:54:27.862317','2024-09-06 11:54:27.862317');
INSERT INTO books VALUES(3,'Essex County','978-1-60309-038-4','1-603-09038-X',500,1990,'',NULL,3,'2024-09-06 11:54:27.879829','2024-09-06 11:54:27.879829');
INSERT INTO books VALUES(4,'Hey, Mister (Vol 1)','978-1-891830-02-0','1-891-83002-3',1200,2000,'After School Special',NULL,3,'2024-09-06 12:16:30.663685','2024-09-06 12:16:30.663685');
INSERT INTO books VALUES(5,'The Underwater Welder','978-1-60309-398-9','1-603-09398-2',3000,2022,'',NULL,4,'2024-09-06 12:16:30.746144','2024-09-06 12:16:30.746144');
CREATE TABLE IF NOT EXISTS "book_authors" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "book_id" integer NOT NULL, "author_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_b23f3934c1"
FOREIGN KEY ("book_id")
  REFERENCES "books" ("id")
, CONSTRAINT "fk_rails_0c0759568d"
FOREIGN KEY ("author_id")
  REFERENCES "authors" ("id")
);
INSERT INTO book_authors VALUES(1,1,1,'2024-09-06 11:54:27.791037','2024-09-06 11:54:27.791037');
INSERT INTO book_authors VALUES(2,1,1,'2024-09-06 11:54:27.793009','2024-09-06 11:54:27.793009');
INSERT INTO book_authors VALUES(3,1,1,'2024-09-06 11:54:27.794507','2024-09-06 11:54:27.794507');
INSERT INTO book_authors VALUES(4,2,1,'2024-09-06 11:54:27.864022','2024-09-06 11:54:27.864022');
INSERT INTO book_authors VALUES(5,3,1,'2024-09-06 11:54:27.882333','2024-09-06 11:54:27.882333');
INSERT INTO book_authors VALUES(6,4,1,'2024-09-06 12:16:30.667117','2024-09-06 12:16:30.667117');
INSERT INTO book_authors VALUES(7,4,1,'2024-09-06 12:16:30.669344','2024-09-06 12:16:30.669344');
INSERT INTO book_authors VALUES(8,4,1,'2024-09-06 12:16:30.671266','2024-09-06 12:16:30.671266');
INSERT INTO book_authors VALUES(9,5,1,'2024-09-06 12:16:30.748099','2024-09-06 12:16:30.748099');
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
