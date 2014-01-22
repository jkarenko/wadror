class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		ratings = Rating.select { |r| r.beer_id == id }
		ratings.inject(0) { |sum, n| sum += n.score } / ratings.count
	end
end
