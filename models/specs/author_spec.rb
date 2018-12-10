require('minitest/autorun')
require('minitest/rg')
require_relative('../author.rb')

class TestAuthor < MiniTest::Test

  def setup
    details = {"name" => "Graham Hancock"}

    @author = Author.new(details)
  end

  def test_name()
    result = @author.name()
    assert_equal("Graham Hancock", result)
  end


end
