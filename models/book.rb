require_relative( '../db/sql_runner' )
require_relative('./author.rb')

class Book

  attr_reader(:id)
  attr_accessor(:title, :author_id, :stock, :description, :buying_price, :selling_price, :category)

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @author_id = details['author_id'].to_i
    @stock = details['stock'].to_i
    @description = details['description']
    @buying_price = details['buying_price'].to_i
    @selling_price = details['selling_price'].to_i
    @category = details['category']
  end

  def save()
    sql = "INSERT INTO books
    (
      title,
      author_id,
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
    values = [@title, @author_id, @stock, @description, @buying_price, @selling_price, @category]
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

  def update()
      sql = "
      UPDATE books SET (
        title,
        author_id,
        stock,
        description,
        buying_price,
        selling_price,
        category
      ) =
      (
        $1, $2, $3, $4, $5, $6, %7
      )
      WHERE id = $8"
      values = [@title, @author_id, @stock, @description, @buying_price, @selling_price, @category, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM books where id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

  def self.delete_all
    sql = "DELETE FROM books"
    SqlRunner.run(sql)
  end

  def stock_status_low
    if @stock < 10 && @stock != 0
      return "Low"
    end
  end

  def stock_status_out
    if @stock == 0
      return "Out of stock"
    end
  end

  def stock_status_good
    if @stock >= 10
      return "Good"
    end
  end

  def author()
    sql = "SELECT * FROM authors WHERE id = $1"
    values = [@author_id]
    result = SqlRunner.run(sql, values)[0]
    return Author.new(result)
  end

  end
