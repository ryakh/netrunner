class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :set_default_rating

  def self.default_rating_values
    {
      rating:          1500,
      deviation:       350,
      volatility:      0.06,
      number_of_games: 0
    }.freeze
  end

  def self.judges
    return User.where(is_judge: true).pluck(:id)
  end

  def self.reset_ratings
    User.all.update_all(User.default_rating_values)
  end

  private
    def set_default_rating
      update(User.default_rating_values)
    end
end
