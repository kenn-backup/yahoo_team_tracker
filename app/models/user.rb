class User < ActiveRecord::Base
  # has_secure_password
  has_many :teams

  after_destroy { |record| Team.destroy(record.teams.pluck(:id))}
end
