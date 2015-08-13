class OrderItem < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'OrderItemAuthorizer'

  before_create :set_price
  before_update :set_price

  belongs_to :order, touch: true
  belongs_to :nomenclature

  validates :price, numericality: { greater_then_or_equal_to: 0.01 }, presence: true
  validates :quantity, numericality: { greater_then_or_qual_to: 0 }, presence: true
  validates :nomenclature, presence: true

  has_paper_trail

  def summa
    (price.nil? || quantity.nil?) ? 0 : price * quantity
  end

  def nds
    (price.nil? || quantity.nil?) ? 0 : (price * quantity * (1 - 1.0 / 1.18)).round(2)
  end

  def nomenclature
    Nomenclature.unscoped { super }
  end

  # validation greater_than 0 don't working, so overwrite quantity method to store only positive values of quantity
  def quantity=(val)
    write_attribute(:quantity, val.to_i.abs)
  end

  def set_price
    if Distributor.current != 0
      self.price = Price.where('nomenclature_id = ? and distributor_id = ?', nomenclature.id, Distributor.current).first.price
    end
  end

  def readonly?
    order_p = Order.find(order_id)
    if order_p.state == 'pending'
      false
    else
      true
    end
  end
end
