class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating_old
		ratings = Rating.select { |r| r.beer_id == id }
		sum = 0
		ratings.each do |r| 
			sum += r.score
		end
		sum/ratings.count
	end

	def average_rating
		ratings = Rating.select { |r| r.beer_id == id }
		ratings.inject(0) { |sum, n| sum += n.score } / ratings.count
	end
end
