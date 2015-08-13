class Message < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MessageAuthorizer'
  paginates_per 10
  belongs_to :user
  belongs_to :parent, class_name: 'Message', foreign_key: 'parent_id'
  has_many :recipients

  validate :recipients_set
  validates :user, presence: true

  scope :outbox_nodelete, -> { where(deleted: false) }

  accepts_nested_attributes_for :recipients,
                                allow_destroy: true,
                                reject_if: :all_blank

  mount_uploader :attachment, AttachmentUploader

  def parents
    @parents ||= Message.get_parents(self)
  end

  private

  def self.get_parents(message)
    @tree ||= []
    if message.parent.nil?
      return @tree
    else
      @tree << message.parent
      get_parents(message.parent)
    end
  end

  def recipients_set
    errors.add(:Recipient, 'Не выбран ни один получатель') if recipients.empty?
  end
end
