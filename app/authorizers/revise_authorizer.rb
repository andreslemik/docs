class ReviseAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    user.has_role?(:logist) || user.has_role?(:distributor)
  end
  def self.creatable_by?(user)
    user.has_role?(:logist) || user.has_role?(:distributor)
  end
  def self.updatable_by?(user)
    user.has_role?(:logist) || user.has_role?(:distributor)
  end
  def self.deletable_by?(user)
    user.has_role?(:logist) || user.has_role?(:distributor)
  end
  def self.fixable_by?(user)
    user.has_role? :logist
  end
  def readable_by?(user)
    if user.has_role? :logist
      true
    else
      resource.distributor.id == user.distributor.id
    end
  end

  def updatable_by?(user)
    if user.has_role? :logist
      resource.state == 'pending'
    else
      resource.distributor.id == user.distributor.id && resource.state == 'pending'
    end
  end

  def deletable_by?(user)
    if user.has_role? :logist
      resource.state == 'pending'
    else
      resource.distributor.id == user.distributor.id && resource.state == 'pending'
    end
  end
end
