require_relative( '../db/sql_runner' )

class Book

  attr_reader(:id, :title, :author, :stock, :description, :buying_price, :selling_price, :category)

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @author = details['author']
    @stock = details['stock']
    @description = details['description']
    @buying_price = details['buying_price'].to_i
    @selling_price = details['selling_price'].to_i
    @category = details['category']
  end

  def save()
    sql = "INSERT INTO books
    (
      title,
      author,
      stock,
      description,
      buying_price,
      selling_price,
      category
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7
    )
    RETURNING id"
    values = [@title, @author, @stock, @description, @buying_price, @selling_price, @category]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM books"
    results = SqlRunner.run(sql)
    return results.map { |book| Book.new(book) }
  end

  def self.find(id)
    sql = "SELECT * FROM books
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Book.new(results.first)
  end

  def self.delete_all
    sql = "DELETE FROM books"
    SqlRunner.run(sql)
  end

end
