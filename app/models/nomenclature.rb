class Nomenclature < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'LogistAuthorizer'

  resourcify
  has_paper_trail
  acts_as_paranoid

  belongs_to :nomenclature_type

  has_many :order_items
  has_many :prices, dependent: :destroy, inverse_of: :nomenclature
  validates_associated :prices
  accepts_nested_attributes_for :prices,
                                allow_destroy: true,
                                reject_if: :all_blank
  has_many :distributors, through: :prices
  accepts_nested_attributes_for :distributors

  validates :name, :partner_number, presence: true
  validates :partner_number, uniqueness: true

  paginates_per 10

  scope :archived, -> { where archived: true }
  scope :mains, -> { where archived: false }

  def prices_for_form
    collection = prices.where(nomenclature_id: id)
    distrs_count = Distributor.count
    collection.any? ? collection : distrs_count.times { prices.build }
  end

  rails_admin do
    list do
      field :partner_number do
        label 'Партнёрский номер'
      end
      field :name do
        label 'Наименование'
      end
    end

    edit do
      field :partner_number do
        label 'Партнёрский номер'
      end
      field :name, :text do
        label 'Описание'
      end
    end
  end
end
