class MessageAuthorizer < ApplicationAuthorizer
  # удалять сообщения полностью могут только логисты
  def self.deletable_by?(user)
    user.has_role? :logist
  end

  # все могут читать сообщения
  def self.readable_by?(_user)
    true
  end

  # все могу изменять сообщения
  def self.updatable_by?(_user)
    true
  end

  # все могут создавать сообщения
  def self.creatable_by?(_user)
    true
  end

  # все могу отвечать на сообщения
  def self.replable_by?(_user)
    true
  end

  # авторизация конкретных сообщений:

  # читать сообщение может либо создавший его, либо тот, кому оно отправлено
  def readable_by?(user)
    resource.user == user || !resource.recipients.where(user: user).blank?
  end

  # отвечать можно только на сообщение, отправленное данному отвечающему
  def replable_by?(user)
    !resource.recipients.where(user: user).blank?
  end
end
