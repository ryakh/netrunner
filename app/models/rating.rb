class Rating
  attr_accessor :rating, :rating_deviation, :volatility

  def initialize(rating, rating_deviation, volatility)
    @rating            = rating
    @rating_deviation  = rating_deviation
    @volatility        = volatility
  end
end
