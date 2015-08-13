class DocumentType < ActiveRecord::Base
  enum tab: { invoices: 1, delivers: 2 }
  acts_as_paranoid

  validates :name, :tab, presence: true

  scope :for_distributor, -> { where(distr: true) }

  rails_admin do
    list do
      field :name do
        label 'Наименование'
      end
      field :distr do
        label 'Доступно дистрибьюторам'
      end
      field :tab do
        label 'Вкладка'
        pretty_value do
          I18n.t :"documenttype_tab.#{bindings[:object].tab}"
        end
      end
    end

    edit do
      field :name do
        label 'Наименование'
      end
      field :distr do
        label 'Доступно для дистрибьюторов'
      end
      field :tab, :enum do
        enum do
          [['Счета, платежки', :invoices], ['Накладные, счета-фактуры', :delivers]]
        end
        label 'Вкладка'
      end
    end
  end
end
