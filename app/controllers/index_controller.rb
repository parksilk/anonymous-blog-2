get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new_post' do
  @post = Post.new
  erb :new_post_form
end

post '/new_post' do
  current_user
  @post = Post.create(:author => params[:author],
                      :title  => params[:title],
                      :body   => params[:body],)

  # abort if post failed to save
  return erb :new_post_form if @post.errors.present?

  clean_tags.each { |tag| @post.tags << tag }

  redirect "/posts/#{@post.id}"
end

get '/posts/:post_id' do
  current_post
  current_tags
  erb :single_post
end

get '/posts/delete/:post_id' do
  current_post
  @post.destroy
  redirect '/'
end

get '/tags' do
  all_tags
  erb :all_tags
end

get '/tags/:tag_name' do
  @tag = Tag.find_by_name(params[:tag_name])
  @posts = @tag.posts
  erb :posts_by_tag
end




  # params[:tags].class <= is a string
  # tags = params[:tags].split(',')
  # tags.each { |t| t.strip! }
  # @tags = []
  # tags.each { |tag| @tags << Tag.find_or_create_by_name(tag) }
  # @tags