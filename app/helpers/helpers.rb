helpers do

  def clean_tags
    tags = params[:tags].split(',')
    tags.each { |t| t.strip! }
    @tags = []
    tags.each { |tag| @tags << Tag.find_or_create_by_name(tag) }
    @tags
  end
end