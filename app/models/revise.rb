class Revise < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ReviseAuthorizer'

  acts_as_paranoid
  paginates_per 10

  belongs_to :distributor
  mount_uploader :file, ActUploader

  scope :current_distr, -> { where(distributor_id: Distributor.current) }

  validates :distributor, presence: true
  validates :date_begin, :date_end, :file, presence: true

  state_machine :state, initial: :pending do
    event :fix do
      transition pending: :fixed
    end
    event :unfix do
      transition fixed: :pending
    end
    state :pending
    state :fixed
  end
end
