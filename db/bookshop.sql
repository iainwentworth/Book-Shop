DROP TABLE books;
DROP TABLE authors;

CREATE TABLE authors
(
  id SERIAL primary key,
  name VARCHAR(255) not null
);

CREATE TABLE books
(
  id SERIAL primary key,
  title VARCHAR(255) not null,
  author_id INT references authors(id) ON DELETE CASCADE,
  stock INT,
  description TEXT,
  buying_price INT,
  selling_price INT,
  category VARCHAR(255)
);
