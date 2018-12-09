require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/author.rb' )
also_reload( '../models/*' )

get '/authors' do
  @authors = Author.all()
  erb ( :"authors/index" )
end

get '/authors/:id' do
  @author = Author.find(params['id'].to_i)
  erb(:"authors/show")
end
