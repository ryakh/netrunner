class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.judges
    return User.where(is_judge: true).pluck(:id)
  end

  def self.reset_ratings
    User.all.update_all(
      rating:     1500,
      deviation:  350,
      volatility: 0.06
    )
  end
end
