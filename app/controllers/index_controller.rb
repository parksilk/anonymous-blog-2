get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new_post' do
  erb :new_post_form
end

post '/new_post' do
  @post = Post.create(:author => params[:author],
                      :title  => params[:title],
                      :body   => params[:body])

  clean_tags if params[:tags]
  
  if clean_tags
    clean_tags.each { |tag| @post.tags << tag }
  end

  if @post.errors.present?
    erb :new_post_form
  else
    redirect "/posts/#{@post.id}"
    # erb :single_post
  end
end

get '/posts/:post_id' do
  current_post
  current_tags
  erb :single_post
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