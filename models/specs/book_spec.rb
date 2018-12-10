require('minitest/autorun')
require('minitest/rg')
require_relative('../book.rb')

class TestBook < MiniTest::Test

  def setup
    details = {"title" => "Title One", "author_id" => "1",
      "stock" => 10, "description" => "Book One Description", "buying_price" => 7, "selling_price" => 10, "category" => "Book One Category"}

    @book = Book.new(details)
  end

  def test_title()
    result = @book.title()
    assert_equal("Title One", result)
  end

  def test_author_id()
    result = @book.author_id()
    assert_equal(1, result)
  end

  def test_description()
    result = @book.description()
    assert_equal("Book One Description", result)
  end

  def test_buying_price()
    result = @book.buying_price()
    assert_equal(7, result)
  end

  def test_selling_price()
    result = @book.selling_price()
    assert_equal(10, result)
  end

  def test_category()
    result = @book.category()
    assert_equal("Book One Category", result)
  end

def test_markup
  result = @book.markup
  assert_equal(3, result)
end

end
