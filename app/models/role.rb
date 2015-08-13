class Role < ActiveRecord::Base
  acts_as_paranoid
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  validates :name, presence: true

  scopify

  rails_admin do
    list do
      field :name do
        label 'Название'
      end
    end
    edit do
      field :name do
        label 'Название'
      end
    end
  end
end
