class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: true

#  def average_rating
#    ratings = Rating.select { |r| r.beer_id == id }
#    ratings.inject(0) { |sum, n| sum += n.score } / ratings.count
#  end

  def to_s
    "#{name} by #{brewery.name}"
  end
end
