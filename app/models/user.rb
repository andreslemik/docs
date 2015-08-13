class User < ActiveRecord::Base
  include Authority::UserAbilities
  acts_as_paranoid
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable, :lockable

  has_paper_trail

  validates :email, :first_name, :last_name, presence: true

  has_one :distributor
  has_many :recipients
  has_many :messages, through: :recipients

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  rails_admin do
    list do
      field :email
      field :full_name do
        label 'ФИО'
      end
      field :roles do
        label 'Роли'
      end
    end

    edit do
      field :email
      field :password do
        label 'Пароль'
      end
      field :last_name do
        label 'Фамилия'
      end
      field :first_name do
        label 'Имя'
      end
      field :roles do
        label 'Роли'
      end
    end
  end

  def full_name
    [last_name, first_name].join(' ')
  end

  def distributor
    Distributor.unscoped { super }
  end
end
