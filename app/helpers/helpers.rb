helpers do

  include SinatraMore::FormatHelpers

  def clean_tags
    return [] unless params[:tags]
    tags = params[:tags].split(',')
    tags.each { |t| t.strip! }
    tags.delete("")
    @tags = []
    tags.each { |tag| @tags << Tag.find_or_create_by_name(tag) }
    @tags
  end

  def get_ten_recent_posts
    @posts = Post.all(:order => "created_at DESC", :limit => 10)
    # @posts = Post.find(:all, :order => "created_at DESC", :limit => 10)
  end

  def current_post
    @post = Post.find(params[:post_id])
  end

  def current_tags
    @tags = current_post.tags
  end

  def all_tags
    @all_tags = Tag.find(:all, :order => 'name')
  end

  # This will return the current user, if they exist
  def current_user
    if session[:remember_token]
      @current_user ||= User.find_by_remember_token(session[:remember_token]) #bugbug
    end
  end

  def login(user)
    session[:remember_token] = user.remember_token
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

end