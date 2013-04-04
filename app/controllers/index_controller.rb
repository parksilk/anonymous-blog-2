get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new_post' do
  erb :new_post_form
end