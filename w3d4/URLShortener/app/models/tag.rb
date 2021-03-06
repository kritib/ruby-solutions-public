class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many :taggings
  has_many :urls, :through => :taggings

  def affix(url)
    # this is a convenience
    Tagging.affix_tag(url, tag)
  end

  def most_popular_urls
    # this is the "real" way to do it
    urls
      .joins(:visits)
      .group("shortened_urls.id")
      .order("COUNT(*) DESC")

    # this is the way you knew how to do on Thu
#    urls.sort_by { |url| url.visits.count }.take(5)

    # Bonus: the slight difference here is that the joins way will
    # drop urls with no visits (why?)
  end
end
