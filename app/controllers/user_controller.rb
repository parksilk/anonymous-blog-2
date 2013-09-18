get '/signup' do
  erb :signup
end

post '/signup' do
 @user = User.new(params[:user])
  if @user.valid?
    @user.save
    login(@user)
    redirect '/'
  else
    erb :index
  end
end


get '/login' do
  erb :login
end

post '/login' do
@password = params[:password]
@user= User.find_by_email(params[:user][:email])
  if @user && @user.authenticate(params[:user][:password])
    login(@user)
    erb :index
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# get '/profile' do
#   erb :profile
# end
