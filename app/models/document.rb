class Document < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'DocumentAuthorizer'

  paginates_per 10

  belongs_to :order, touch: true
  belongs_to :document_type
  belongs_to :user
  has_one :distributor, through: :order

  mount_uploader :file, DocumentUploader
  validates :file, :document_type, :user, presence: true

  scope :invoices, -> { where document_type_id: DocumentType.where(tab: DocumentType.tabs[:invoices]) }
  scope :delivers, -> { where document_type_id: DocumentType.where(tab: DocumentType.tabs[:delivers]) }
  scope :current_distr, -> { joins(:distributor).where('distributors.id =?', Distributor.current) }

  def read_uploader(column)
    self[column]
  end

  def write_uploader(column, identifier)
    self[column] = identifier
  end

  def user
    User.unscoped { super }
  end

  def document_type
    DocumentType.unscoped { super }
  end
end
