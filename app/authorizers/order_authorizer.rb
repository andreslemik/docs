class OrderAuthorizer < ApplicationAuthorizer
  def self.deletable_by?(user)
    user.has_role?(:distributor)
  end

  def self.readable_by?(user)
    user.has_any_role? :distributor, :logist
  end

  def self.updatable_by?(user)
    user.has_any_role? :distributor, :logist
  end

  def self.creatable_by?(user)
    user.has_role?(:distributor)
  end

  def readable_by?(user)
    resource.distributor == user.distributor || user.has_role?(:logist)
  end

  def updatable_by?(user)
    resource.distributor == user.distributor || user.has_role?(:logist)
  end

  def deletable_by?(user)
    (resource.distributor == user.distributor || user.has_role?(:logist)) && resource.state == 'pending'
  end

  def docsable_by?(user)
    resource.distributor == user.distributor
  end

  def acceptable_by?(user)
    user.has_role?(:logist)
  end

  def payable_by?(user)
    user.has_role?(:logist)
  end

  def shipable_by?(user)
    user.has_role?(:logist)
  end

  def unacceptable_by?(user)
    user.has_role?(:logist)
  end

  def unpayable_by?(user)
    user.has_role?(:logist)
  end

  def unshipable_by?(user)
    user.has_role?(:logist)
  end
end
