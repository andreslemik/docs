class DistributorAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    user.has_role?(:logist)
  end

  def self.creatable_by?(user)
    user.has_role? :logist
  end

  def self.deletable_by?(user)
    user.has_role? :logist
  end

  def self.updatable_by?(user)
    user.has_role? :logist
  end
end
