class DocumentAuthorizer < ApplicationAuthorizer
  def self.deletable_by?(user)
    user.has_role?(:distributor) || user.has_role?(:logist)
  end
  def self.readable_by?(_user)
    true
  end
  def self.updatable_by?(_user)
    true
  end
  def self.creatable_by?(user)
    user.has_role?(:distributor) || user.has_role?(:logist)
  end
  def readable_by?(user)
    resource.order.distributor == user.distributor || user.has_role?(:logist)
  end

  def deletable_by?(user)
    (resource.user == user && resource.order.state != 'shipped') || user.has_role?(:logist)
  end

  def updatable_by?(user)
    (resource.user == user && resource.order.state != 'shipped') || user.has_role?(:logist)
  end
end
