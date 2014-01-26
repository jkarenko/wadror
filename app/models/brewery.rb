class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def average_rating
    ratings = Rating.select { |r| r.beer_id == id }
    byebug
    ratings.inject(0) { |sum, n| sum += n.score } / ratings.count

  end

end
