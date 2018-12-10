require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/book.rb' )
also_reload( '../models/*' )

get '/books' do
  @books = Book.all()
  erb ( :"books/index" )
end

get '/books/:id' do
  @book = Book.find(params['id'].to_i)
  erb( :"books/show" )
end

post '/books/:id/delete' do
  book = Book.find(params[:id].to_i())
  book.delete()
  redirect('/books')
end

get '/books/:id/edit' do
  @book = Book.find(params[:id].to_i())
  erb(:"books/edit")
end
