class Match < ActiveRecord::Base
  belongs_to :first_player, class_name: 'User'
  belongs_to :second_player, class_name: 'User'
  belongs_to :first_player_corporation, class_name: 'Identity'
  belongs_to :first_player_runner, class_name: 'Identity'
  belongs_to :second_player_corporation, class_name: 'Identity'
  belongs_to :second_player_runner, class_name: 'Identity'
end
