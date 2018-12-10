require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/book.rb' )
also_reload( '../models/*' )

get '/books' do
  @books = Book.all()
  erb ( :"books/index" )
end

get '/books/new' do
  @books = Book.all
  @authors = Author.all
  @categories = ["Science-fiction", "Fantasy"]
  erb(:"books/new")
end

post '/books' do
  Book.new(params).save
  redirect to '/books'
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
  @authors = Author.all
  @book = Book.find(params[:id].to_i())
  @categories = ["Science-fiction", "Fantasy"]
  erb(:"books/edit")
end

post '/books/:id' do
  book = Book.new(params)
  book.update
  redirect to "/books/#{params['id']}"
end
