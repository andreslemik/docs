class NomenclatureType < ActiveRecord::Base
  validates :name, presence: true
  has_many :nomenclatures

  rails_admin do
    list do
      field :name do
        label 'Наименование'
      end
    end

    edit do
      field :name do
        label 'Наименование'
      end
    end
  end
end
