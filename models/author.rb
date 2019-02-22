require_relative( '../db/sql_runner' )
require_relative('./book.rb')

class Author

  attr_reader :id
  attr_accessor :name

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

  def save()
    sql = "INSERT INTO authors
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM authors"
    results = SqlRunner.run(sql)
    return results.map { |hash| Author.new(hash) }
  end

  def self.find(id)
    sql = "SELECT * FROM authors
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Author.new(results.first)
  end

  def update()
      sql = "
      UPDATE authors SET name = $1 WHERE id = $2"
      values = [@name, @id]
      SqlRunner.run(sql, values)
    end

  def delete()
    sql = "DELETE FROM authors where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM authors"
    SqlRunner.run( sql )
  end

# Prepare SQL to select everything from books by author
# Run it against the database using SQLRunner
# The list of books will be returned from database
# The list of books is then converted into a list of book objects
# The list of book objects is then returned
def books
  sql = "SELECT * FROM books WHERE author_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  books = results.map {|book_hash| Book.new(book_hash)}
  return books
 end


end
