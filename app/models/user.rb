class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :set_default_rating

  def self.judges
    return User.where(is_judge: true).pluck(:id)
  end

  def self.reset_ratings
    User.all.update_all(
      rating:          1500.00000000000,
      deviation:       350.00000000000,
      volatility:      0.06000000000,
      number_of_games: 0
    )
  end

  private
    def set_default_rating
      update_attributes(
        rating:          BigDecimal.new(1500),
        deviation:       BigDecimal.new(350),
        volatility:      BigDecimal.new(0.06),
        number_of_games: 0
      )
    end
end
