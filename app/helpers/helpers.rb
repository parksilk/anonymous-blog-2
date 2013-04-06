helpers do

  def clean_tags
    return [] unless params[:tags]
    tags = params[:tags].split(',')
    tags.each { |t| t.strip! }
    tags.delete("")
    @tags = []
    tags.each { |tag| @tags << Tag.find_or_create_by_name(tag) }
    @tags
  end

  def get_ten_posts
    @posts = Post.find(:all, :order => "created_at", :limit => 10)
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

end