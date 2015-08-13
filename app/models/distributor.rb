class Distributor < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'DistributorAuthorizer'

  acts_as_paranoid
  belongs_to :user
  has_many :prices
  has_many :revises, inverse_of: :distributor

  validates :name, :user, presence: true
  validates :name, uniqueness: true

  def self.current
    Thread.current[:distributor]
  end
  def self.current=(distributor)
    Thread.current[:distributor] = distributor
  end

  def user
    User.unscoped { super }
  end

  rails_admin do
    visible false
  end
end
