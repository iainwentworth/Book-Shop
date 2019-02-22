require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('controllers/books_controller')
require_relative('controllers/authors_controller')

get '/' do
  erb(:index)
end
