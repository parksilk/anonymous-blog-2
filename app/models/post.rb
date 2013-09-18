class Post < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :title, :presence => true
  validates :body, :presence => true

  def post_time
    hour = self.created_at.hour
    ampm = "a.m."
    if hour >= 13
      hour -= 12
      ampm = "p.m."
    end
    min  = self.created_at.min

    "#{hour}:#{min} #{ampm}"
  end
end
