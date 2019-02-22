require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/author.rb' )

get '/authors' do
  @authors = Author.all()
  erb ( :"authors/index" )
end

get '/authors/new' do
  erb(:"authors/new")
end

post '/authors' do
  Author.new(params).save
  redirect to '/authors'
end

get '/authors/:id' do
  @author = Author.find(params['id'].to_i)
  erb(:"authors/show")
end

post '/authors/:id/delete' do
  author = Author.find(params[:id].to_i())
  author.delete()
  redirect('/authors')
end

get '/authors/:id/edit' do
  @author = Author.find(params[:id].to_i())
  erb(:"authors/edit")
end

post '/authors/:id' do
  author = Author.new(params)
  author.update
  redirect to "/authors/#{params['id']}"
end
