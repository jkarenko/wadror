class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 15 }

  validates :password, format: { :with => /(?=.*[a-zA-Z])(?=.*[0-9]).{4,}/ }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  def favorite_beer
    return nil if ratings.empty?
    #ratings.sort_by{ |r| r.score }.last.beer
    #ratings.sort_by(&:score).last.beer # same thing but shorter, though makes two select statements
    ratings.order(score: :desc).limit(1).first.beer # a more optimized version with only one select statement
  end

end
