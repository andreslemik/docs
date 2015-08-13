class Order < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 10

  include Authority::Abilities
  self.authorizer_name = 'OrderAuthorizer'

  has_paper_trail

  belongs_to :distributor
  belongs_to :user
  has_many :documents, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :documents,
                                allow_destroy: true,
                                reject_if: :all_blank

  has_many :order_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: :all_blank

  validates :distributor, :user, presence: true

  scope :current_distr, -> { where(distributor_id: Distributor.current) }

  ransacker :created_at, type: :date do |_parent|
    Arel::Nodes::SqlLiteral.new('DATE(orders.created_at)')
  end

  ### state_machine
  state_machine :state, initial: :pending do
    after_transition on: :accept do |order|
      order.send_email
    end
    event :accept do
      transition pending: :accepted
    end
    event :unaccept do
      transition accepted: :pending
    end
    event :pay do
      transition [:accepted, :shipped] => :paid
    end
    event :unpay do
      transition paid: :accepted
    end
    event :ship do
      transition [:paid, :accepted] => :shipped
    end
    event :unship do
      transition shipped: :accepted
    end
    state :pending
    state :accepted
    state :paid
    state :shipped
  end

  ############
  def user
    User.unscoped { super }
  end

  def total_summa
    order_items.to_a.sum(&:summa)
  end

  def total_nds
    order_items.to_a.sum(&:nds)
  end

  #### rails admin
  rails_admin do
    list do
      field :id do
        label '№'
      end
      field :distributor do
        label 'Дистрибьютор'
      end
      field :created_at do
        label 'Добавлен'
      end
      field :updated_at do
        label 'Изменен'
      end
      field :user do
        label 'Добавил'
        pretty_value do
          user = User.find(bindings[:object].user_id.to_s)
          user.full_name
        end
      end
    end
  end

  def send_email
    notify_users = User.with_role(:logist) - User.with_role(:logist_prime)
    notify_users.each do |u|
      UserMailer.new_order(u, self).deliver
    end
  end
end
