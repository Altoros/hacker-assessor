class Career < ActiveRecord::Base
  has_many :hackers
  has_many :requirements

  validates :name, presence: true, uniqueness: true
end
