class Price < ActiveRecord::Base
  include Authority::UserAbilities
  belongs_to :distributor
  belongs_to :nomenclature

  validates :distributor, uniqueness: { scope: :nomenclature }
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def nomenclature
    Nomenclature.unscoped { super }
  end

  def distributor
    Distributor.unscoped { super }
  end
end
